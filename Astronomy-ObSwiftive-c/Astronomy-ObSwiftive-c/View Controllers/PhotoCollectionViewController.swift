//
//  PhotoCollectionViewController.swift
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/22/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UIViewController {
    
    var photoController = PhotoController()
    var roverPhotos: [RoverPhoto]?
    
    @IBOutlet var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Methods
    func loadImage(forCell cell: RoverPhotoCollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PhotoDetailSegue" {
            let photoDetailVC = segue.destination as? RoverPhotoDetailViewController

            guard let cell = sender as? UICollectionViewCell,
                let indexPath = self.collectionView.indexPath(for: cell) else { return }
            
            photoDetailVC?.photoController = photoController
            photoDetailVC?.roverPhoto = photoController.roverPhotos[indexPath.row]
        }
        
    }
}

extension PhotoCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoController.roverPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? RoverPhotoCollectionViewCell ?? RoverPhotoCollectionViewCell()
        
        loadImage(forCell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    
}
