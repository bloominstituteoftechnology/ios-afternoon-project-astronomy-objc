//
//  ViewController.swift
//  Astronomy
//
//  Created by Shawn Gee on 5/18/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var photo: MarsPhoto?
    
    // MARK: - IBOutlets
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var cameraLabel: UILabel!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        guard let photo = photo else { return }
        
        if let imageURL = photo.imageURL.usingHTTPS,
           let imageData = try? Data(contentsOf: imageURL) {
            imageView.image = UIImage(data: imageData)
        }
        
        descriptionLabel.text = "Taken by \(photo.roverID) on \(photo.earthDate) (Sol \(photo.solNumber))"
        cameraLabel.text = "Camera: \(photo.cameraName)"
    }

    // MARK: - IBActions
    
    @IBAction func saveToPhotoLibrary(_ sender: Any) {
        // TODO: Implement saving to photo library
    }
    
}

