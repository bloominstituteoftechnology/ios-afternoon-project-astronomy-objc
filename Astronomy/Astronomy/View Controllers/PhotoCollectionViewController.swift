//
//  PhotoCollectionViewController.swift
//  Astronomy
//
//  Created by Jesse Ruiz on 12/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SolPhoto"

class PhotoCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    var marsRoverClient = MarsRoverClient()
    private var photos = [MarsPhotoReference]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - Methods
    private func fetchPhotos() {
        marsRoverClient.fetchPhotos(2) { (photos, error) in
            if let error = error {
                NSLog("Error fetching photos: \(error)")
                return
            }
            DispatchQueue.main.async {
                if let photos = photos {
                    self.photos = photos
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotos()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        let photo = photos[indexPath.item]
        
        if let imageData = try? Data(contentsOf: photo.imageURL),
            let image = UIImage(data: imageData) {
            cell.imageView.image = image
        }
        return cell
    }
}
