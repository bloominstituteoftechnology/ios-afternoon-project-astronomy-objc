//
//  SolPhotoCollectionViewCell.swift
//  Astronomy-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class SolPhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage(named: "MarsPlaceholder")
    }
}
