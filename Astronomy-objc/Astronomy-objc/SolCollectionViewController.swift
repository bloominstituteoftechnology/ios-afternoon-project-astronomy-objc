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
    var currentSol = 0 // Sol 0 has too many photos, so for optimization/testing the starting default sol is 1
    var photoUrls = [String]() {
        didSet {
            imageCache.clear()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var photoCount = Int() {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
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
            
            self.photoCount = allPhotos.photos.count
            
            for photo in allPhotos.photos {
                let imgSrc = photo.imgSrc
                self.photoUrls.append(imgSrc)
            }
        }
    }
    
    
    
    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? RoverPhotoCollectionViewCell else { return UICollectionViewCell() }
        
        fetchImage(forCell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    
    // MARK: - Rover Image Fetching Methods and Operations
    
    func fetchImage(forCell cell: RoverPhotoCollectionViewCell, forItemAt indexPath: IndexPath) {
        let imageURLString = photoUrls[indexPath.item]
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
