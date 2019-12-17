//
//  ImageCollectionViewCell.swift
//  Astronomy
//
//  Created by Jesse Ruiz on 12/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = #imageLiteral(resourceName: "MarsPlaceholder")
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        imageView.image = #imageLiteral(resourceName: <#T##String#>)
//
//    }
    
    @IBOutlet weak var imageView: UIImageView!
}
