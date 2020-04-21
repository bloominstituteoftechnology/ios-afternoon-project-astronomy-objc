//
//  PhotoCollectionViewCell.swift
//  iOS9-Astronomy
//
//  Created by Jake Connerly on 11/12/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = #imageLiteral(resourceName: "marvin")
    }
    
    @IBOutlet weak var imageView: UIImageView!
}
