//
//  SolCollectionViewController.swift
//  Astronomy-objc
//
//  Created by Dillon P on 4/26/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

import UIKit

private let reuseIdentifier = "RoverPhotoCell"

class SolCollectionViewController: UICollectionViewController {
    
    let marsRoverController = MarsRoverController()
    var rover: Rover?
    var sols: [Int32]?
    var currentSol = 1 // Sol 0 has too many photos, so for optimization/testing the starting default sol is 1
    var marsRoverPhotos = [MarsRoverPhoto]() {
        didSet {
            imageCache.clear()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var imageCache = Cache(key: String(), value: Data())
    var operations = [String : Operation]()
    
    let imageFetchOperationQueue = OperationQueue()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        fetchMissionManifest()
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPhotoDetailSegue" {
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            if let photoDetailVC = segue.destination as? PhotoDetailViewController {
                let marsRoverPhotoRef = marsRoverPhotos[indexPath.item]
                
                let imageURLString = marsRoverPhotoRef.imgSrc
                let httpURL = URL(string: imageURLString)
                guard let httpsURLString = getSecureURL(url: httpURL) else { return }
                guard let imageData = imageCache.value(forKey: httpsURLString) as? Data else { return }
                photoDetailVC.title = "Photo Details"
                photoDetailVC.marsRoverPhoto = marsRoverPhotoRef
                photoDetailVC.imageData = imageData
            }
        }
    }
    
    private func updateViews() {
        self.title = "Sol \(currentSol)"
        self.collectionView.reloadData()
    }
    
    // MARK: - Initial App Load Networking Methods
    
    private func fetchMissionManifest() {
        marsRoverController.fetchMissionManifest { (rover, error) in
            if let error = error {
                print("Error fetching mission manifest: \(error)")
            }

            if let rover = rover {
                self.rover = rover
                
                guard let sols = rover.sols as? [Int32] else {
                    print("Sols could not be loaded")
                    return
                }
                let sol = sols[self.currentSol]
                
                self.loadPhotoRefsForSol(sol: sol)
                
                return
            }
        }
    }
    
    private func loadPhotoRefsForSol(sol: Int32) {
        marsRoverController.fetchAllPhotos(forSol: sol) { (allPhotos, error) in
            
            defer { self.updateViews() }
            
            if let error = error {
                print("Error fetching photos for sol: \(error)")
                return
            }
            
            guard let allPhotos = allPhotos else {
                print("Error loading all photo references")
                return
            }
            
            self.marsRoverPhotos = allPhotos.photos
        }
    }
    
    
    
    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return marsRoverPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? RoverPhotoCollectionViewCell else { return UICollectionViewCell() }
        
        fetchImage(forCell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    
    //MARK: UICollectionViewDelegate Methods
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if marsRoverPhotos.count > 0 {
            let photo = marsRoverPhotos[indexPath.item]
            let imSrcString = photo.imgSrc
            operations[imSrcString]?.cancel()
        } else {
            for (_, operation) in operations {
                operation.cancel()
            }
        }
    }
    
    // MARK: - Rover Image Fetching Methods and Operations
    
    func fetchImage(forCell cell: RoverPhotoCollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = marsRoverPhotos[indexPath.item]
        let imageURLString = photo.imgSrc
        let httpURL = URL(string: imageURLString)
        
        guard let httpsURLString = getSecureURL(url: httpURL) else {
            return
        }
        
        if let cachedData = imageCache.value(forKey: httpsURLString) as? Data {
            DispatchQueue.main.async {
                guard let image = UIImage(data: cachedData) else { return }
                cell.roverImage.image = image
            }
        }
        
        let fetchOp = FetchRoverImageOperation(imageURLString: httpsURLString)
        
        let cacheOp = BlockOperation {
            guard let data = fetchOp.imgData else { return }
            self.imageCache.cacheValue(data, forKey: httpsURLString)
        }
        
        let completionOp = BlockOperation {
            defer { self.operations.removeValue(forKey: imageURLString) }
            
            if let currentIndex = self.collectionView.indexPath(for: cell), currentIndex != indexPath {
                return
            }
            
            if let imageData = fetchOp.imgData, let image = UIImage(data: imageData) {
                cell.roverImage.image = image
            }
        }
        
        cacheOp.addDependency(fetchOp)
        completionOp.addDependency(fetchOp)
        
        imageFetchOperationQueue.addOperation(fetchOp)
        imageFetchOperationQueue.addOperation(cacheOp)
        
        OperationQueue.main.addOperation(completionOp)
        
        operations[imageURLString] = fetchOp
    }

    
    private func getSecureURL(url: URL?) -> String? {
        guard let url = url, var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        components.scheme = "https"
        return components.url?.absoluteString
    }
    
}
