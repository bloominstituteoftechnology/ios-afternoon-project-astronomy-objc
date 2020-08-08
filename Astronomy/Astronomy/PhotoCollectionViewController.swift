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

}
