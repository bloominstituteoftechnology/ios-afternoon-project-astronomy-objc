//
//  ImageCollectionViewCell.swift
//  Astronomy-Hybrid
//
//  Created by Vici Shaweddy on 2/12/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.imageView.image = #imageLiteral(resourceName: "MarsPlaceholder")
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
    }
}
