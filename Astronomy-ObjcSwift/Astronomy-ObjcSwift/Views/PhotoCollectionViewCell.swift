//
//  PhotoCollectionViewCell.swift
//  Astronomy-ObjcSwift
//
//  Created by Hunter Oppel on 6/15/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var imageView: UIImageView!
    
    lazy var imageFetcher = ImageFetcher()
    private lazy var photoFetchQueue = OperationQueue()
    
    var photo: Photo? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let photo = photo,
            let imgURL = photo.imgURL.usingHTTPS else { return }
        activityIndicator.startAnimating()
        
        fetchAndSetImage(url: imgURL)
    }
    
    private func fetchAndSetImage(url: URL) {
        let fetchPhoto = ImageFetcherOperation(url: url)
        let setImageToCell = BlockOperation {
            let imageData = fetchPhoto.imageData
            guard let image = UIImage(data: imageData) else { return }
            
            self.imageView.image = image
        }
        
        setImageToCell.addDependency(fetchPhoto)
        photoFetchQueue.addOperation(fetchPhoto)
        OperationQueue.main.addOperation(setImageToCell)
    }
}
