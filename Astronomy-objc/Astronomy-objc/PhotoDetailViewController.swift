//
//  PhotoDetailViewController.swift
//  Astronomy-objc
//
//  Created by Dillon P on 4/26/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    @IBOutlet weak var marsRoverImage: UIImageView!
    @IBOutlet weak var photoDetailsLabel: UILabel!
    @IBOutlet weak var cameraDetailsLabel: UILabel!
    @IBOutlet weak var savePhotoButton: UIButton!
    
    var marsRoverPhoto: MarsRoverPhoto?
    var imageData: Data?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let marsRoverPhoto = marsRoverPhoto, let imageData = imageData, let image = UIImage(data: imageData) else { return }
        
        let roverName = marsRoverPhoto.rover.name
        
        let earthDateString = marsRoverPhoto.earthDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let earthDate = dateFormatter.date(from: earthDateString) else { return }
        dateFormatter.dateFormat = "M/d/yy"
        let formattedEarthDate = dateFormatter.string(from: earthDate)
        
        let sol = marsRoverPhoto.sol
        let cameraName = marsRoverPhoto.camera.fullName
        
        photoDetailsLabel.text = "Taken by \(roverName) on \(formattedEarthDate) (Sol \(sol))"
        cameraDetailsLabel.text = "Camera: \(cameraName)"
        marsRoverImage.image = image
        
    }
    
    
    func savePhotoToLibrary(UIImage: UIImage) {
        // TODO: Request permission to users Photos library
        
        // TODO: Save photo to library
        
        // TODO: Present alert for confirmation
    }
    
    // MARK: - Actions
    
    @IBAction func savePhotoButtonTapped(_ sender: Any) {
        if let image = marsRoverImage.image {
            savePhotoToLibrary(UIImage: image)
        }
    }
    
}
