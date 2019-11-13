//
//  PhotosCollectionViewController.swift
//  iOS9-Astronomy
//
//  Created by Jake Connerly on 11/12/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit


class PhotosCollectionViewController: UICollectionViewController {
    
    var photoController = JLCPhotoController()
    private var photos = [JLCMarsPhoto]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotos()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    private func fetchPhotos() {
        
        photoController.fetchPhotosfromSol(2) { (photos, error) in
            if let error = error {
                NSLog("Error fetching photos from sol#\(2) with:\(error)")
                return
            }
            
            DispatchQueue.main.async {
                if let photos = photos {
                    self.photos = photos                    
                }
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarsPhotoCell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        let photo = photos[indexPath.item]
        
        if let imageData = try? Data(contentsOf: photo.imageURL),
            let image = UIImage(data: imageData) {
            cell.imageView.image = image
            
        }
        return cell
    }
}
