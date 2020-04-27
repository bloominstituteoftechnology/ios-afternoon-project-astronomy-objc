//
//  RoverPhotoCollectionViewCell.swift
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/27/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

import UIKit

class RoverPhotoCollectionViewCell: UICollectionViewCell {
    
    var roverPhoto: RoverPhoto? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet var roverPhotoImageView: UIImageView!
    
    func updateViews() {
        guard let roverPhoto = roverPhoto else { return }
    }
    
}
