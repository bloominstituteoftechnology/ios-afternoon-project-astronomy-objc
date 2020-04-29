//
//  RoverPhotoCollectionViewCell.swift
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/27/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

import UIKit

class RoverPhotoCollectionViewCell: UICollectionViewCell {
    

    override func prepareForReuse() {
        super.prepareForReuse()
        roverPhotoImageView.image = #imageLiteral(resourceName: "MarsPlaceholder")
    }
    
    @IBOutlet var roverPhotoImageView: UIImageView!
    
}
