//
//  PhotoCollectionViewCell.swift
//  Astronomy-objc
//
//  Created by Matthew Martindale on 8/9/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var marsPhoto: MarsPhotoReference? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        if let photo = marsPhoto {
            guard let url = URL(string: photo.imageURLString) else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            imageView.image = UIImage(data: imageData)
        }
    }
    
}
