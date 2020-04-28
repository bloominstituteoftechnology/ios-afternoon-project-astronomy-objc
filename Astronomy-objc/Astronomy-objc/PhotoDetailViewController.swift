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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let marsRoverPhoto = marsRoverPhoto else { return }
        
        let roverId = marsRoverPhoto.rover.identifier
        let roverName = marsRoverPhoto.rover.name
        let earthDate = marsRoverPhoto.earthDate
        let sol = marsRoverPhoto.sol
        
        let cameraName = marsRoverPhoto.camera.fullName
        
        photoDetailsLabel.text = "Taken by Rover #\(roverId) (\(roverName)) on \(earthDate) (\(sol))"
        cameraDetailsLabel.text = "Camera: \(cameraName)"
        
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
