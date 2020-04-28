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
    private let cache = Cache()
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

    }
    
    // MARK: - Methods
    func loadImage(forCell cell: RoverPhotoCollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let roverPhotos = roverPhotos else { return }
        let roverPhoto = roverPhotos[indexPath.row]
        
        if let cachedImage = cache.value(roverPhoto.photoID) {
            cell.roverPhotoImageView.image = cachedImage
            return
        }
        
        
        
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

extension PhotoCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoController.roverPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? RoverPhotoCollectionViewCell ?? RoverPhotoCollectionViewCell()
        
        loadImage(forCell: cell, forItemAt: indexPath)
        
        return cell
    }
    
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
        return UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 10.0)
    }
    
}
