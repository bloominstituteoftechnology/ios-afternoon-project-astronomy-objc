//
//  PhotoCollectionViewController.swift
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/22/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UIViewController {
    
    private var photoController = PhotoController()
    var validSols: [Int]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    private let cache = Cache()
    private let  photoFetchQueue = OperationQueue()
    private var operations = [Int : Operation]()
    
    var roverPhotos: [RoverPhoto]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    @IBOutlet var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let roverName = "curiosity"
        let initialSol: Int32 = 3
        
        photoController.fetchPhotoManifest(roverName) { (possibleManifest, possibleError) in
            if let error = possibleError {
                NSLog("Error fetching Photo Manifest: \(error)")
                return
            }
            
            if let photoManifest = possibleManifest {
                guard let validSols = photoManifest.sols else { return }
                self.validSols = validSols
            }
        }
        
        photoController.fetchRoverPhotos(roverName, initialSol) { (possiblePhoto, possibleError) in
            if let error = possibleError {
                NSLog("Error fetching Rover Photo: \(error)")
                return
            }
            self.roverPhotos = possiblePhoto?.roverPhotos
        }

    }
    
    // MARK: - Methods
    func loadImage(forCell cell: RoverPhotoCollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let roverPhotos = roverPhotos else { return }
        let roverPhoto = roverPhotos[indexPath.row]
        
        if let cachedImage = cache.value(roverPhoto.photoID) as? UIImage {
            cell.roverPhotoImageView.image = cachedImage
            return
        }
        
        let fetchOp = FetchPhotoOperation(roverPhotoReference: roverPhoto)
        let cacheOp = BlockOperation {
            let image = fetchOp.roverPhoto
            self.cache.cache(roverPhoto.photoID, forValue: image)
        }
        
        let completionOp = BlockOperation {
            defer { self.operations.removeValue(forKey: Int(roverPhoto.photoID)) }
            
            if let newIndexPath = self.collectionView.indexPath(for: cell),
                newIndexPath != indexPath { return }
            let image = fetchOp.roverPhoto
            cell.roverPhotoImageView.image = image
        }
        
        cacheOp.addDependency(fetchOp)
        completionOp.addDependency(fetchOp)
        
        photoFetchQueue.addOperation(fetchOp)
        photoFetchQueue.addOperation(cacheOp)
        OperationQueue.main.addOperation(completionOp)
        
        operations[Int(roverPhoto.photoID)] = fetchOp
        
    }
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PhotoDetailSegue" {
            let photoDetailVC = segue.destination as? RoverPhotoDetailViewController

            guard let cell = sender as? UICollectionViewCell,
                let indexPath = self.collectionView.indexPath(for: cell) else { return }
            
            photoDetailVC?.photoController = photoController
            photoDetailVC?.roverPhoto = roverPhotos![indexPath.row]
        }
    }
}

extension PhotoCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roverPhotos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? RoverPhotoCollectionViewCell ?? RoverPhotoCollectionViewCell()
        
        loadImage(forCell: cell, forItemAt: indexPath)
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        guard let roverPhotos = roverPhotos else { return }
//        if roverPhotos.count > 0 {
//            let roverPhoto = roverPhotos[indexPath.item]
//            operations[Int(roverPhoto.photoID)]?.cancel()
//        } else {
//            for (_, operation) in operations {
//                operation.cancel()
//            }
//        }
//    }
    
    func collectionView(_collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        var totalUsableWidth = collectionView.frame.width
        let inset = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
        totalUsableWidth -= inset.left + inset.right
        
        let minWidth: CGFloat = 150.0
        let numberOfItemsInOneRow = Int(totalUsableWidth / minWidth)
        totalUsableWidth -= CGFloat(numberOfItemsInOneRow - 1) * flowLayout.minimumInteritemSpacing
        let width = totalUsableWidth / CGFloat(numberOfItemsInOneRow)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5.0, bottom: 0, right: 5.0)
    }
    
}
