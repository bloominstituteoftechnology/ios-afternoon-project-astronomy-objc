//
//  ImageCollectionViewCell.swift
//  Astronomy-ObjC
//
//  Created by John Kouris on 2/12/20.
//  Copyright © 2020 John Kouris. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = #imageLiteral(resourceName: "MarsPlaceholder")
    }
    
}
