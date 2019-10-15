//
//  ImageCollectionViewCell.swift
//  Astronomy-objc
//
//  Created by Bradley Yin on 10/15/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = #imageLiteral(resourceName: "MarsPlaceholder")
    }
}
