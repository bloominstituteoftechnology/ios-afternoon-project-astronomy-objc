//
//  PhotoCollectionViewCell.swift
//  Astronomy
//
//  Created by Christopher Aronson on 7/23/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
    var photoURL: String?
    var roverController: RoverController?
    
    func loadImage() {
        guard let photoURL = photoURL,
        let roverController = roverController,
        let url = URL(string: photoURL)?.usingHTTPS
        else { return }
        
        
        
        roverController.fetchImage(from: url) { (imageData, error) in
            
            if let error = error {
                print("Error fetching image: \(error)");
                return
            }
            
            DispatchQueue.main.async {
                guard let imageData = imageData,
                let image = UIImage(data: imageData)
                else { return }
                
                self.photoImageView.image = image
            }
            
        }
    }
}
