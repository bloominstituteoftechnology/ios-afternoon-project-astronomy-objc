//
//  PhotoDetailViewController.swift
//  iOS9-Astronomy
//
//  Created by Jake Connerly on 11/12/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var roverLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    
    var photo: JLCMarsPhoto?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        guard let photo = photo else { return }
        if let imageData = try? Data(contentsOf: photo.imageURL),
            let image = UIImage(data: imageData) {
            imageView.image = image
        }
        let rover = photo.rover.name
        let camera = photo.camera.fullName
        
        roverLabel.text = "Taken by \(rover) on \(photo.earthDate)"
        cameraLabel.text = "Camera \(photo.camera.fullName)"
    }
 
    @IBAction func saveButtonTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
