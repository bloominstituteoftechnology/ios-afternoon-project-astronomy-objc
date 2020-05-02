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
    
    @IBOutlet weak var previousSolButton: UIBarButtonItem!
    @IBOutlet weak var nextSolButton: UIBarButtonItem!
    
    
    let marsRoverController = MarsRoverController()
    var rover: Rover?
    var sols: [Int32]?
    // Sol 0 has too many photos, so for optimization/testing the starting default sol is 1
    var currentSol = Int32() {
        didSet {
            marsRoverPhotos.removeAll()
            imageFetchOperationQueue.cancelAllOperations()
            operations.removeAll()
            updateViews()
            loadPhotoRefsForSol(sol: currentSol)
        }
    }
    
    var marsRoverPhotos = [MarsRoverPhoto]() {
        didSet {
            collectionView.reloadData()
        }
    }
    var imageCache = Cache(key: String(), value: Data())
    var operations = [String : Operation]()
    
    let imageFetchOperationQueue = OperationQueue()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if !marsRoverPhotos.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    private func updateViews() {
        if currentSol == 0 {
            previousSolButton.isEnabled = false
        } else {
            previousSolButton.isEnabled = true
        }
        self.title = "Sol \(currentSol)"
    }
    
    // MARK: - Initial App Load Networking Methods
    
    private func fetchMissionManifest() {
        marsRoverController.fetchMissionManifest { (rover, error) in
            if let error = error {
                print("Error fetching mission manifest: \(error)")
            }

            if let rover = rover {
                self.rover = rover
                
                guard let sols = rover.sols as? [Int32], let firstSol = sols.first else {
                    print("Sols could not be loaded")
                    return
                }
                self.sols = sols
                self.currentSol = firstSol
                return
            }
        }
    }
    
    private func loadPhotoRefsForSol(sol: Int32) {
        marsRoverController.fetchAllPhotos(forSol: sol) { (allPhotos, error) in
            
//            defer { self.collectionView.reloadData() }
            
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
        var count = Int()
        if marsRoverPhotos.isEmpty {
            count = 100
        } else {
            count = marsRoverPhotos.count
        }
        return count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? RoverPhotoCollectionViewCell else { return UICollectionViewCell() }
        if !marsRoverPhotos.isEmpty {
            fetchImage(forCell: cell, forItemAt: indexPath)
        }
        return cell
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
    
    
// MARK: - IBActions
    
    @IBAction func previousSolTapped(_ sender: Any) {
        guard currentSol > 0 else { return }
        guard let sols = sols, let currentIndex = sols.firstIndex(of: currentSol) else { return }
        
        let previousSol = sols[currentIndex - 1]
        currentSol = previousSol
    }
    
    
    @IBAction func nextSolTapped(_ sender: Any) {
        guard let sols = sols, let currentIndex = sols.firstIndex(of: currentSol) else { return }
        if currentSol == sols.last {
            return
        }
        
        let nextSol = sols[currentIndex + 1]
        currentSol = nextSol
    }
    
    
}
