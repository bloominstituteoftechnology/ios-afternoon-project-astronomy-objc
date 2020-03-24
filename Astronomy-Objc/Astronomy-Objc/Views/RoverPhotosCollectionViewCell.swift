//
//  RoverPhotosCollectionViewCell.swift
//  Astronomy-Objc
//
//  Created by Michael on 3/23/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class RoverPhotosCollectionViewCell: UICollectionViewCell {
    
    var photo: MBMPhoto? {
        didSet {
            updateViews()
        }
    }
    
    
    @IBOutlet var imageView: UIImageView!
    
    func updateViews() {
       
        guard let photo = photo else {
            print("There is no photo being passed")
            return
        }
        
        if let url = URL(string: photo.imgSrc)?.usingHTTPS, let data = try? Data(contentsOf: url) {
            imageView.image = UIImage(data: data)
        }
        
        
    }
    
}
