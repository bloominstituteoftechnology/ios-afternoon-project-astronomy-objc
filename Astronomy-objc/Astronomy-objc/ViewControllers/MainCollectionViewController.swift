//
//  MainCollectionViewController.swift
//  Astronomy-objc
//
//  Created by Bradley Yin on 10/14/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ImageCell"

class MainCollectionViewController: UICollectionViewController {
    
    private let client = BYMarsRoverClient()
    private var roverInfo: BYMarsRover? {
        didSet {
            solDescription = roverInfo?.solDescriptions[100]
        }
    }
    private var solDescription: BYSolDescription? {
        didSet {
            if let rover = roverInfo,
                let sol = solDescription?.sol {
                client.fetchPhotos(from: rover, onSol: sol) { (photoRefs, error) in
                    if let e = error { NSLog("Error fetching photos for \(rover.name) on sol \(sol): \(e)"); return }
                    self.photoReferences = photoRefs ?? []
                }
            }
        }
    }
    private var photoReferences = [BYMarsPhotoReference]() {
        didSet {
            DispatchQueue.main.async { self.collectionView?.reloadData() }
        }
    }
    
    let cache = BYCache()
    
    private let photoFetchQueue = OperationQueue()
    private var fetchDictionary: [Int: Operation] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        client.fetchMarsRover(withName: "curiosity") { (rover, error) in
            if let error = error {
                NSLog("Error fetching info for curiosity: \(error)")
                return
            }
            
            self.roverInfo = rover
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
        // #warning Incomplete implementation, return the number of items
        return photoReferences.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCollectionViewCell else { fatalError("cannot make imageCell") }
        
        
        let photoReference = photoReferences[indexPath.row]
        
        if let cacheData = cache.value(forKey: photoReference.refernceId.stringValue) {
            cell.imageView.image = UIImage(data: cacheData)
            return cell
        }
        
        let url = photoReference.imageURL
        
        client.fetchImage(fromPhotoURL: url) { (data, error) in
            if let error = error {
                print("error fetching image: \(error)")
            }
            guard let data = data else { return }
            self.cache.cacheValue(forKey: photoReference.refernceId.stringValue, value: data)
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data)
            }
            
        }
        
        
        return cell
    }
    
    private func loadImage(forCell cell: ImageCollectionViewCell, forItemAt indexPath: IndexPath) {
            
            let photoReference = photoReferences[indexPath.item]
            
            let photoFetchOperation = FetchPhotoOperation(marsPhotoReference: photoReference)
            let saveCacheOperation = BlockOperation {
                self.cache.cache(value: photoFetchOperation.imageData!, for: photoReference.id)
            }
            let setUpImageViewOperation = BlockOperation {
                DispatchQueue.main.async {
                    
                    cell.imageView.image = UIImage(data: photoFetchOperation.imageData!)
                    
                }
            }
            if let imageData = cache.value(for: photoReference.id) {
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    cell.imageView.image = image
                    print("loaded cache image")
                    return
                }
            }

            saveCacheOperation.addDependency(photoFetchOperation)
            setUpImageViewOperation.addDependency(photoFetchOperation)
            photoFetchQueue.addOperations([photoFetchOperation, saveCacheOperation, setUpImageViewOperation], waitUntilFinished: true)
            
            fetchDictionary[photoReference.id] = photoFetchOperation
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

}

