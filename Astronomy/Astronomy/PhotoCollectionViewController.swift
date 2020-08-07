//
//  PhotoCollectionViewController.swift
//  Astronomy
//
//  Created by Claudia Maciel on 8/7/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PhotoCell"

class PhotoCollectionViewController: UICollectionViewController {

    private let photoFetcher = PhotoFetcher()
    private var photos = [Photo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoFetcher.fetchPhotos(fromSol: 10) { (possiblePhotos, possibleError) in
            if let error = possibleError {
                NSLog("Error fetching photos from sol: \(error)")
                return
            }
            
            guard let photos = possiblePhotos, photos.count > 0 else {
                NSLog("No photos returned")
                return
            }
            
            self.photos = photos
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewPhotoSegue" {
            guard let detailVC = segue.destination as? PhotoDetailViewController,
            let cell = sender as? PhotoCollectionViewCell,
                let indexPath = collectionView.indexPath(for: cell) else { return }
            detailVC.photo = photos[indexPath.row]
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
    
        cell.photo = photos[indexPath.row]
    
        return cell
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
