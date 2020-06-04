//
//  SolPhotosCollectionViewController.swift
//  Astronomy-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PhotoCell"

class SolPhotosCollectionViewController: UICollectionViewController {

    
    private let roverController = RoverController()
    private let cache = Cache<NSNumber, NSData>()
    private let photoFetchQueue = OperationQueue();
    private var operations = [Int: Operation]();

    private var marsRover: MarsRover? {
        didSet {
            solDescription = marsRover?.solDescriptions[4]
        }
    }
    private var solDescription: SolDescription? {
        didSet {
            if let sol = solDescription?.sol {
                print("Description for Sol: \(sol)")
                photoReferences = []
                roverController.photosForRover(onSol: sol) { (photoRefs, error) in
                    if let error = error {
                        print("Error fetching photos \(error)")
                        return
                    }
                    self.photoReferences = photoRefs ?? []
                    DispatchQueue.main.async { self.updateViews() }
                }
            }
        }
    }
    private var photoReferences = [PhotoReference]() {
        didSet {
            cache.clear()
            DispatchQueue.main.async { self.collectionView?.reloadData() }
        }
    }

    private func updateViews() {

    }

    private func loadImage(forCell cell: SolPhotoCollectionViewCell, forItemAt indexPath: IndexPath) {
        let photoReference = photoReferences[indexPath.item]

        if let data = cache.value(photoReference.solId) as? Data {
            cell.imageView.image = UIImage(data: data)
            return
        }

        let fetchOp = FetchPhotoOperation(photoReference: photoReference)
        let cacheOp = BlockOperation {
            if let data = fetchOp.imageData {
                self.cache.cacheValue(data, key: photoReference.solId)
            }
        }

        let completionOp = BlockOperation {
            defer { self.operations.removeValue(forKey: Int(photoReference.solId)) }

            if let currentIndexPath = self.collectionView.indexPath(for: cell),
                currentIndexPath != indexPath {
                print("Cell has been reused")
                return
            }
            if let data = fetchOp.imageData {
                cell.imageView.image = UIImage(data: data)
            }
        }

        cacheOp.addDependency(fetchOp)
        completionOp.addDependency(fetchOp)

        photoFetchQueue.addOperations([fetchOp, cacheOp], waitUntilFinished: true)
        OperationQueue.main.addOperation(completionOp)
        operations[Int(photoReference.solId)] = fetchOp
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        roverController.photoManifest { (rover, error) in
            if let error = error {
                print("Error getting photo manifest \(error)")
                return
            }

            self.marsRover = rover
        }

//        roverController.photosForRover(onSol: "10") { (error) in
//            if let error = error {
//                print("Error getting photos \(error)")
//            } else {
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                }
//            }
//        }
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

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoReferences.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? SolPhotoCollectionViewCell else { return UICollectionViewCell() }
    
        loadImage(forCell: cell, forItemAt: indexPath)
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        let photoReference = photoReferences[indexPath.item]
        operations[Int(photoReference.solId)]?.cancel()
    }

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
