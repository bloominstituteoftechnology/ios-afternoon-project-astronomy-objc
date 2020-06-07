//
//  PhotosCollectionViewController.swift
//  Astronomy
//
//  Created by David Wright on 6/3/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ImageCell"

class PhotosCollectionViewController: UICollectionViewController {

    // MARK: - Properties
    
    private let client = MarsRoverClient()
    
    private var roverInfo: MarsRover? {
        didSet {
            solDescription = roverInfo?.solDescriptions[0]
        }
    }
    
    private var solDescription: SolDescription? {
        didSet {
            if let rover = roverInfo,
                let sol = solDescription?.sol {
                photoReferences = []
                client.fetchPhotos(from: rover, onSol: sol) { photoRefs, error in
                    if let error = error { NSLog("Error fetching photos for \(rover.name) on sol \(sol): \(error)"); return }
                    self.photoReferences = photoRefs ?? []
                    DispatchQueue.main.async { self.updateViews() }
                }
            }
        }
    }
    
    private var photoReferences = [MarsPhotoReference]() {
        didSet {
            // TODO: Clear the cache here
            DispatchQueue.main.async { self.collectionView?.reloadData() }
        }
    }
    
    private let solLabel = UILabel()
    
    // TODO: Add additional properties: cache, photoFetchQueue, and operations
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let roverName = "curiosity"
        
        client.fetchMarsRover(withName: roverName) { rover, error in
            if let error = error {
                NSLog("Error fetching info for \(roverName): \(error)")
                return
            }
            
            self.roverInfo = rover
        }
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        configureTitleView()
        updateViews()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            let detailVC = segue.destination as! PhotoDetailViewController
            detailVC.photo = photoReferences[indexPath.item]
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func goToPreviousSol(_ sender: Any?) {
        guard let solDescription = solDescription else { return }
        guard let solDescriptions = roverInfo?.solDescriptions else { return }
        guard let index = solDescriptions.firstIndex(of: solDescription) else { return }
        guard index > 0 else { return }
        self.solDescription = solDescriptions[index-1]
    }
    
    @IBAction func goToNextSol(_ sender: Any?) {
        guard let solDescription = solDescription else { return }
        guard let solDescriptions = roverInfo?.solDescriptions else { return }
        guard let index = solDescriptions.firstIndex(of: solDescription) else { return }
        guard index < solDescriptions.count - 1 else { return }
        self.solDescription = solDescriptions[index+1]
    }
    
    // MARK: - Private Methods
    
    private func configureTitleView() {
        
        let font = UIFont.systemFont(ofSize: 30)
        let attrs = [NSAttributedString.Key.font: font]

        let prevTitle = NSAttributedString(string: "<", attributes: attrs)
        let prevButton = UIButton(type: .system)
        prevButton.accessibilityIdentifier = "PhotosCollectionViewController.PreviousSolButton"
        prevButton.setAttributedTitle(prevTitle, for: .normal)
        prevButton.addTarget(self, action: #selector(goToPreviousSol(_:)), for: .touchUpInside)
        
        let nextTitle = NSAttributedString(string: ">", attributes: attrs)
        let nextButton = UIButton(type: .system)
        nextButton.setAttributedTitle(nextTitle, for: .normal)
        nextButton.addTarget(self, action: #selector(goToNextSol(_:)), for: .touchUpInside)
        nextButton.accessibilityIdentifier = "PhotosCollectionViewController.NextSolButton"
        
        let stackView = UIStackView(arrangedSubviews: [prevButton, solLabel, nextButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = UIStackView.spacingUseSystem
        
        navigationItem.titleView = stackView
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        solLabel.text = "Sol \(solDescription?.sol ?? 0)"
    }
    
    private func loadImage(forCell cell: ImageCollectionViewCell, forItemAt indexPath: IndexPath) {
        let photoReference = photoReferences[indexPath.item]
        
        // TODO: Check the cache for the photo here
        
        let urlString = photoReference.imageURL.absoluteString
        
        client.fetchPhoto(withURLString: urlString, using: nil) { photo, _ in
            guard let photo = photo else { return }
            cell.image = photo;
        }
    }
}


// MARK: - UICollectionViewDataSource

extension PhotosCollectionViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation
        // TODO: Add proper accessors to the internal array of the model controller
        NSLog("num photos: \(photoReferences.count)") // #warning Remove this line when finished testing
        return photoReferences.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ImageCollectionViewCell ?? ImageCollectionViewCell()
        
        loadImage(forCell: cell, forItemAt: indexPath)
    
        return cell
    }
}
