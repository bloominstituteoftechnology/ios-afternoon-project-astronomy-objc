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
    
    var photo: Photo? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let photo = photo,
            let imgURL = photo.imgURL.usingHTTPS else { return }
        activityIndicator.startAnimating()
        
        imageFetcher.fetchImage(from: imgURL) { data, error in
            if let error = error {
                NSLog("Failed to fetch image with error: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data was returned")
                return
            }
            
            guard let image = UIImage(data: data) else {
                NSLog("Could not convert data into image")
                return
            }
            
            DispatchQueue.main.async {
                self.imageView.image = image
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
