//
//  PhotoCollectionViewController.swift
//  Astronomy
//
//  Created by Chris Dobek on 6/17/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

import UIKit

private let reuseIdentifier = "RoverPhotoCell"

class PhotoCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var previousSolButton: UIBarButtonItem!
    @IBOutlet weak var nextSolButton: UIBarButtonItem!
    
    let marsRoverController = CMDMarsRoverController()
    var rover: CMDRover?
    var sols: [Int32]?
    var isLoadingPhotos = false {
        didSet {
            if isLoadingPhotos == false {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    var currentSol = Int32() {
        didSet {
            if !isLoadingPhotos {
                isLoadingPhotos = true
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            updateViews()
            loadPhotoRefsForSol(sol: currentSol)
        }
    }
    
    var marsRoverPhotos = [MarsRoverPhoto]()
    
    var imageCache = CMDCache(key: String(), value: Data())
    let loadingPhotosOperationQueue = OperationQueue()
    var photoRefsOperations = [Int32: Operation]()
    
    let imageFetchOperationQueue = OperationQueue()
    var imageLoadOperations = [String: Operation]()
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 20.0,
                                             left: 20.0,
                                             bottom: 20.0,
                                             right: 20.0)
    
    
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
                
                let imageURLString = marsRoverPhotoRef.imgScr
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
        marsRoverController.fetchManifest { (rover, error) in
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
                self.isLoadingPhotos = true
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func loadPhotoRefsForSol(sol: Int32) {
        let loadingPhotoRefOperation = BlockOperation {
            self.marsRoverController.fetchPhotos(forSol: sol) { (allPhotos, error) in
                
                if let error = error {
                    print("Error fetching photos for sol: \(error)")
                    return
                }
                
                guard let allPhotos = allPhotos else {
                    print("Error loading all photo references")
                    return
                }
                
                self.marsRoverPhotos = allPhotos.photos
                if sol == self.currentSol {
                    self.isLoadingPhotos = false
                }
            }
        }
        
        loadingPhotosOperationQueue.addOperation(loadingPhotoRefOperation)
        photoRefsOperations[sol] = loadingPhotoRefOperation
    }
    
    
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = Int()
        if isLoadingPhotos {
            count = 100
        } else {
            count = marsRoverPhotos.count
        }
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        if !isLoadingPhotos {
            fetchImage(forCell: cell, forItemAt: indexPath)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if marsRoverPhotos.isEmpty {
            return
        } else {
            guard !imageLoadOperations.isEmpty else { return }
            guard marsRoverPhotos.count >= indexPath.item else { return }
            let photoSrc = marsRoverPhotos[indexPath.item].imgScr
            guard let operation = imageLoadOperations[photoSrc] else { return }
            operation.cancel()
            imageLoadOperations.removeValue(forKey: photoSrc)
        }
    }
    
    // MARK: - Rover Image Fetching Methods and Operations
    
    func fetchImage(forCell cell: PhotoCollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = marsRoverPhotos[indexPath.item]
        let imageURLString = photo.imgScr
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
        
        let fetchOp = CMDFetchPhotoOperation(imageURLString: httpsURLString)
        
        let cacheOp = BlockOperation {
            guard let data = fetchOp.imgData else { return }
            self.imageCache.cacheValue(data, forKey: httpsURLString)
        }
        
        let completionOp = BlockOperation {
            defer { self.imageLoadOperations.removeValue(forKey: imageURLString) }
            
            if let currentIndex = self.collectionView.indexPath(for: cell), currentIndex != indexPath {
                return
            }
            
            if let imageData = fetchOp.imgData, let image = UIImage(data: imageData) {
                cell.roverImage.image = image
            }
        }
        
       imageFetchOperationQueue.addOperation(cacheOp)
       
       OperationQueue.main.addOperation(completionOp)
        
    }
    
    
    private func getSecureURL(url: URL?) -> String? {
        guard let url = url, var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        components.scheme = "https"
        return components.url?.absoluteString
    }
    
    
    // MARK: - IBActions
    
    @IBAction func previousSolTapped(_ sender: Any) {
        guard currentSol > 0 else { return }
        prepareForSolChange()
        guard let sols = sols, let currentIndex = sols.firstIndex(of: currentSol) else { return }
        let previousSol = sols[currentIndex - 1]
        currentSol = previousSol
    }
    
    
    @IBAction func nextSolTapped(_ sender: Any) {
        guard let sols = sols, let currentIndex = sols.firstIndex(of: currentSol) else { return }
        if currentSol == sols.last {
            return
        }
        prepareForSolChange()
        let nextSol = sols[currentIndex + 1]
        currentSol = nextSol
    }
    
    
    private func prepareForSolChange() {
        if photoRefsOperations.count > 0 {
            if let operation = photoRefsOperations[currentSol] {
                operation.cancel()
            }
        }
        photoRefsOperations.removeAll()
        marsRoverPhotos.removeAll()
        imageFetchOperationQueue.cancelAllOperations()
        imageLoadOperations.removeAll()
    }
    
    
}


// MARK: - Collection View Flow Layout Delegate
extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
