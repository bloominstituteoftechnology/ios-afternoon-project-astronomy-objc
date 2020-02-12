//
//  PhotosCollectionViewController.swift
//  Astronomy-Hybrid
//
//  Created by Bobby Keffury on 2/12/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    //MARK: - Properties
    
    private let client = MarsRoverClient()
    private let cache = Cache<Int, UIImage>()
    private let photoFetchQueue = OperationQueue()
    private var operations = [Int : Operation]()
    let solLabel = UILabel()
    
    private var roverInfo: MarsRover? {
        didSet {
            solDescription = roverInfo?.solDescriptions[1]
        }
    }
    
    private var solDescription: SolDescription? {
        didSet {
            if let rover = roverInfo,
                let sol = solDescription?.sol {
                client.fetchPhotos(from: rover, onSol: sol, using: URLSession.shared) { (photoRefs, error) in
                    if let e = error { NSLog("Error fetching photos for \(rover.name) on sol \(sol): \(e)"); return }
                    self.photoReferences = photoRefs ?? []
                    DispatchQueue.main.async { self.updateViews() }
                }
            }
        }
    }
    
    private var photoReferences = [MarsPhotoReference]() {
        didSet {
            cache.clear()
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }
    
    //MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         client.fetchMarsRover(named: "curiosity", using: URLSession.shared) { (rover, error) in
             if let error = error {
                 NSLog("Error fetching info for curiosity: \(error)")
                 return
             }
             
             self.roverInfo = rover
         }
        
        configureTitleView()
        updateViews()
    }

    //MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        NSLog("num photos: \(photoReferences.count)")
        return photoReferences.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCollectionViewCell ?? ImageCollectionViewCell()
    
        loadImage(forCell: cell, forItemAt: indexPath)
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if photoReferences.count > 0 {
            let photoRef = photoReferences[indexPath.item]
            operations[photoRef.id]?.cancel()
        } else {
            for (_, operation) in operations {
                operation.cancel()
            }
        }
    }

    
    //MARK: - Methods
    
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
        // Check for image in cache
        if let cachedImage = cache.value(for: photoReference.id) {
            cell.imageView.image = cachedImage
            return
        }
        
        // Start an operation to fetch image data
        let fetchOp = FetchPhotoOperation(photoReference: photoReference)
        let cacheOp = BlockOperation {
            if let image = fetchOp.image {
                self.cache.cache(value: image, for: photoReference.id)
            }
        }
        let completionOp = BlockOperation {
            defer { self.operations.removeValue(forKey: photoReference.id) }
            
            if let currentIndexPath = self.collectionView?.indexPath(for: cell),
                currentIndexPath != indexPath {
                return // Cell has been reused
            }
            
            if let image = fetchOp.image {
                cell.imageView.image = image
            }
        }
        
        cacheOp.addDependency(fetchOp)
        completionOp.addDependency(fetchOp)
        
        photoFetchQueue.addOperation(fetchOp)
        photoFetchQueue.addOperation(cacheOp)
        OperationQueue.main.addOperation(completionOp)
        
        operations[photoReference.id] = fetchOp
    }
    
    //MARK: - Actions
    
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
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            
        }
    }

}
