//
//  PhotoCollectionViewCell.swift
//  Astronomy
//
//  Created by Claudia Maciel on 8/7/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var roverImage: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var photo: Photo? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let photo = photo else { return }
        activityIndicator.startAnimating()
        
        guard let imageData = try? Data(contentsOf: photo.imgURL) else { return }
        roverImage.image = UIImage(data: imageData)
        activityIndicator.stopAnimating()
    }
    
}
