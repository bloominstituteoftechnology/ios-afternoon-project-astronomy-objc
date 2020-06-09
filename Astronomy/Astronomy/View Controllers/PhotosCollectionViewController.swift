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
            // #warning change index to "0" when finished testing
            // index 654 has 1 photo; index 53 has 4 photos; index 81 has 9 photos; index 4 has 26 photos
            solDescription = roverInfo?.solDescriptions[4]
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
            photoDictionary = [:]
            DispatchQueue.main.async { self.collectionView?.reloadData() }
            print("Fetched \(photoReferences.count) photo references.") // #warning Remove this line when finished testing
        }
    }
    
    // TODO: Add additional properties: cache, photoFetchQueue, and operations
    
    private let solLabel = UILabel()
    private let minimumSpacing: CGFloat = 8.0
    private var photoDictionary = [Int: UIImage]()
    
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
        
        self.collectionView!.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(refresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        configureTitleView()
        updateViews()
    }
    
    @objc func refresh() {
        collectionView.reloadData()
        collectionView.refreshControl?.endRefreshing()
        print("The collection view has been refreshed!")
        print("There are \(collectionView.numberOfItems(inSection: 0)) total cells.")
        print("There are \(collectionView.visibleCells.count) visible cells.")
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first,
                let detailVC = segue.destination as? PhotoDetailViewController else { return }
            
            detailVC.photoReference = photoReferences[indexPath.item]
            
            guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell,
                let image = cell.imageView.image else { return }
            
            detailVC.image = image
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
        if let photo = photoDictionary[photoReference.id] {
            cell.imageView.image = photo;
            return;
        }
        
        let urlString = photoReference.imageURL.absoluteString
        
        client.fetchPhoto(withURLString: urlString, using: nil) { photo, _ in
            guard let photo = photo else { return }
            self.photoDictionary[photoReference.id] = photo;
            cell.imageView.image = photo;
        }
    }
}


// MARK: - UICollectionViewDataSource

extension PhotosCollectionViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoReferences.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ImageCollectionViewCell ?? ImageCollectionViewCell()
        
        loadImage(forCell: cell, forItemAt: indexPath)
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected item #: \(indexPath.item)")
        self.performSegue(withIdentifier: "ShowDetail", sender: self)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var totalUsableWidth = collectionView.bounds.size.width - minimumSpacing
        let inset = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
        totalUsableWidth -= (inset.left + inset.right)
        
        let minWidth: CGFloat = 150.0
        let numberOfItemsInOneRow = Int(totalUsableWidth / (minWidth + minimumSpacing))
        totalUsableWidth -= CGFloat(numberOfItemsInOneRow) * minimumSpacing
        let width = totalUsableWidth / CGFloat(numberOfItemsInOneRow)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: minimumSpacing, bottom: 0, right: minimumSpacing)
    }
}
