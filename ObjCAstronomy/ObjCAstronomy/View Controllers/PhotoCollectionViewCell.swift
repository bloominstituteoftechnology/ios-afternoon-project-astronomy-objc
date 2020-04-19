//
//  PhotoCollectionViewCell.swift
//  ObjCAstronomy
//
//  Created by Mitchell Budge on 7/23/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = #imageLiteral(resourceName: "MarsPlaceholder")
    }
    
    // MARK: Properties
    
    @IBOutlet var imageView: UIImageView!
    
}
