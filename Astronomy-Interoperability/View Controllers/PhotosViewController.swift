//
//  PhotosViewController.swift
//  Astronomy-Interoperability
//
//  Created by Christian Lorenzo on 6/3/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    // MARK: - Properties:
    let photoController = PhotoController()
    var hasFinished: Bool = false
    var hasPhotoFinished: Bool = false
    var arrayOfFilters: [Photo] = []
    var sol: Int = 2
    let cache = NSCache<NSNumber, UIImage>()
    var operationsDict: [Int : Operation] = [:]
    let photoFetchQueue = OperationQueue()
    
    // MARK: - Outlets
    @IBOutlet weak var collectonView: UICollectionView!
    @IBOutlet weak var previousSolButton: UIBarButtonItem!
    @IBOutlet weak var nextSolButton: UIBarButtonItem!
    @IBOutlet weak var cameraSegmentedControl: UISegmentedControl!
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraSegmentedControl.isEnabled = false
        previousSolButton.isEnabled = false
        setupCollectionViewCells()
        networkRequest()
    }
    
    // MARK: Private Methods
    private func networkRequest() {
        photoController.fetchManifest { error in
            if let error = error {
                print("Error fetching manifest \(error)")
                return
            }
            
            self.hasFinished = true
            
            DispatchQueue.main.async {
                self.collectonView.reloadData()
                self.setupSegmentedControl()
                self.title = "Sol \(Int((self.photoController.manifests[self.sol] as! Manifest).solID))"
            }
            
            self.photoController.fetchSol(by: self.photoController.manifests[self.sol] as! Manifest) { error in
                if let error = error {
                    print("Error fetching manifest \(error)")
                    return
                }
                
                DispatchQueue.main.async {
                    self.collectonView.reloadData()
                    self.hasPhotoFinished = true
                    self.cameraSegmentedControl.isEnabled = true
                }
            }
        }
    }
    
    private func setupSegmentedControl() {
        cameraSegmentedControl.removeAllSegments()
        
        var i = 1
        cameraSegmentedControl.insertSegment(withTitle: "NONE", at: 0, animated: true)
        for item in (photoController.manifests[sol] as! Manifest).cameras {
            cameraSegmentedControl.insertSegment(withTitle: item, at: i, animated: true)
            i += 1
        }
        cameraSegmentedControl.selectedSegmentIndex = 0
    }
    
    private func setupCollectionViewCells() {
        if let flowLayout = collectonView.collectionViewLayout as? UICollectionViewFlowLayout {
            let cols: CGFloat = 2
            let spacing: CGFloat = 2
            let edge = (collectonView.bounds.width - spacing * (cols - 1)) / cols
            flowLayout.itemSize.width = edge
            flowLayout.itemSize.height = edge
            flowLayout.minimumInteritemSpacing = spacing
            flowLayout.minimumLineSpacing = spacing
            flowLayout.sectionInset = .zero
        }
    }
    
    // MARK: - IBAction
    @IBAction func lastSolButtonTapped(_ sender: Any) {
        if hasFinished {
            
            hasPhotoFinished = false
            cameraSegmentedControl.isEnabled = false
            
            if self.sol != 0 {
                self.sol -= 1
                self.setupSegmentedControl()
                self.title = "Sol \(Int((self.photoController.manifests[self.sol] as! Manifest).solID))"
            }
            
            photoController.fetchSol(by: self.photoController.manifests[self.sol] as! Manifest) { error in
                if let error = error {
                    print("Error fetching manifest: \(error)")
                    return
                }
                
                DispatchQueue.main.async {
                    self.hasPhotoFinished = true
                    self.collectonView.reloadData()
                    self.cameraSegmentedControl.isEnabled = true
                }
            }
        }
    }
    
    @IBAction func solButtonTapped(_ sender: Any) {
        if hasFinished, sol < Int((self.photoController.manifests.count - 1)) {
            
            self.sol += 1
            hasPhotoFinished = false
            cameraSegmentedControl.isEnabled = false
            self.title = "Sol \(Int((self.photoController.manifests[self.sol] as! Manifest).solID))"
            self.previousSolButton.isEnabled = true
            self.setupSegmentedControl()
            
            photoController.fetchSol(by: self.photoController.manifests[self.sol] as! Manifest) { error in
                if let error = error {
                    print("Error fetching manifest \(error)")
                    return
                }
                
                DispatchQueue.main.async {
                    self.hasPhotoFinished = true
                    self.collectonView.reloadData()
                    self.cameraSegmentedControl.isEnabled = true
                }
            }
        }
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            arrayOfFilters.removeAll()
            collectonView.reloadData()
        } else {
            let title = sender.titleForSegment(at: sender.selectedSegmentIndex)
            arrayOfFilters.removeAll()
            for photo in photoController.photos {
                let photo = photo as! Photo
                
                if photo.cameraName == title {
                    arrayOfFilters.append(photo)
                }
            }
            collectonView.reloadData()
        }
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            guard let photoVC = segue.destination as? PhotoDetailViewController else { return }
            guard let selected = collectonView.indexPathsForSelectedItems else { return }
            
            if arrayOfFilters.count != 0 {
                photoVC.photo = arrayOfFilters[selected[0].row]
            } else {
                photoVC.photo = (photoController.photos[selected[0].row] as! Photo)
            }
            
            photoVC.photoController = photoController
        }
    }
}

    // MARK: - Delegate and DataSource

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if arrayOfFilters.count != 0 {
            return arrayOfFilters.count
        } else if hasFinished {
            return Int((photoController.manifests[sol] as! Manifest).photoCount)
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
        
        if arrayOfFilters.count != 0 {
            cell.textLabel.text = "\(arrayOfFilters[indexPath.row].photoID)"
            loadImage(at: cell, with: indexPath, for: arrayOfFilters[indexPath.row])
        } else if hasPhotoFinished {
            cell.textLabel.text = "\((photoController.photos[indexPath.row] as! Photo).photoID)"
            loadImage(at: cell, with: indexPath, for: (photoController.photos[indexPath.row] as! Photo))
        }
        
        return cell
    }
    
    private func loadImage(at cell: PhotosCollectionViewCell, with indexPath: IndexPath, for photo: Photo) {
        let photoID = NSNumber(value: photo.photoID)
            if let cachedVersion = cache.object(forKey: photoID) {
                cell.imageView.image = cachedVersion
            } else {
                let fetchPhotoOperation = FetchPhotoOperation(reference: photo)
                
                let cacheImageData = BlockOperation {
                    let image = UIImage(data: fetchPhotoOperation.imageData)
                    if let image = image {
                        self.cache.setObject(image, forKey: photoID)
                    }
                }
                
                let finalBlock = BlockOperation {
                    if let cachedImage = self.cache.object(forKey: photoID) {
                        cell.imageView.image = cachedImage
                    }
                }
                
                cacheImageData.addDependency(fetchPhotoOperation)
                finalBlock.addDependency(cacheImageData)
                
                photoFetchQueue.addOperations([cacheImageData, fetchPhotoOperation], waitUntilFinished: false)
                OperationQueue.main.addOperation(finalBlock)
                
                operationsDict[photo.photoID] = fetchPhotoOperation
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photoId = (self.photoController.photos[indexPath.item] as! Photo).photoID
        if let op = operationsDict[photoId] {
            op.cancel()
        }
    }
}
