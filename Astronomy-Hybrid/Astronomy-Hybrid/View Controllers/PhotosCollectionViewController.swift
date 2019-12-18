//
//  PhotosCollectionViewController.swift
//  Astronomy-Hybrid
//
//  Created by Isaac Lyons on 12/16/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PhotoCell"

class PhotosCollectionViewController: UICollectionViewController {
    
    //MARK: Properties
    
    let client = MarsRoverClient()
    var rover: MarsRover? {
        didSet {
            sol = rover?.sols[1]
        }
    }
    var photos: [MarsPhotoReference] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var sol: Sol? {
        didSet {
            cache = Cache<NSNumber, UIImage>()
            updateViews()
            fetchPhotos()
        }
    }
    
    private let photoFetchQueue = OperationQueue()
    private var fetchOperations: [Int: FetchPhotoOperation] = [:]
    
    private var cache = Cache<NSNumber, UIImage>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        client.fetchMarsRoverNamed("curiosity") { rover, error in
            if let error = error {
                NSLog("\(error)")
                return
            }
            
            guard let rover = rover else {
                NSLog("No rover returned")
                return
            }
            
            DispatchQueue.main.async {
                print("Rover: \(rover.name)")
                
                self.rover = rover
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(photos.count)
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
    
        loadImage(forCell: cell, forItemAt: indexPath)
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        fetchOperations[indexPath.item]?.cancel()
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    //MARK: Private
    
    private func loadImage(forCell cell: ImageCollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let photoReference = photos[indexPath.item]
        
        if let image = cache.value(forKey: NSNumber(value: indexPath.item)) {
            OperationQueue.main.addOperation {
                cell.imageView.image = image
            }
        } else {
            let fetchOperation = FetchPhotoOperation(photoReference: photoReference)
            
            let saveToCache = BlockOperation {
                guard let image = UIImage(data: fetchOperation.imageData ?? Data()) else { return }
                self.cache.cacheValue(image, forKey: NSNumber(value: indexPath.item))
            }
            
            let setCellImage = BlockOperation {
                guard let image = UIImage(data: fetchOperation.imageData ?? Data()) else { return }
                if self.collectionView.indexPath(for: cell) == indexPath {
                    cell.imageView.image = image
                }
            }
            
            saveToCache.addDependency(fetchOperation)
            setCellImage.addDependency(fetchOperation)
            
            photoFetchQueue.addOperations([fetchOperation, saveToCache], waitUntilFinished: false)
            OperationQueue.main.addOperations([setCellImage], waitUntilFinished: false)
            
            fetchOperations[photoReference.id] = fetchOperation
        }
    }
    
    private func updateViews() {
        if let rover = rover {
            navigationItem.prompt = "\(rover.name) Rover"
        }
        
        if let sol = sol {
            title = "Sol \(sol.sol)"
        }
    }
    
    private func fetchPhotos() {
        guard let rover = rover,
            let sol = sol else { return }
        self.client.fetchPhotos(from: rover, onSol: sol.sol) { photos, error in
            if let error = error {
                NSLog("\(error)")
                return
            }
            
            guard let photos = photos else {
                NSLog("No photos returned")
                return
            }
            
            DispatchQueue.main.async {
                self.photos = photos
            }
        }
    }
    
    //MARK: Actions
    
    @IBAction func nextSol(_ sender: UIBarButtonItem) {
        guard let rover = rover,
            let sol = sol,
            let solIndex = rover.sols.firstIndex(of: sol) else { return }
        
        
        if solIndex + 1 < rover.sols.count {
            self.sol = rover.sols[solIndex + 1]
        } else {
            self.sol = rover.sols.first
        }
    }
    
    @IBAction func previousSol(_ sender: UIBarButtonItem) {
        guard let rover = rover,
            let sol = sol,
            let solIndex = rover.sols.firstIndex(of: sol) else { return }
        
        
        if solIndex - 1 >= 0 {
            self.sol = rover.sols[solIndex - 1]
        } else {
            self.sol = rover.sols.last
        }
    }
    
}

//MARK: Collection view delegate flow layout

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
        return UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 10.0)
    }
}
