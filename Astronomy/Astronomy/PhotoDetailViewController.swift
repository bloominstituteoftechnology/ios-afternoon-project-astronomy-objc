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
    
    // MARK: - Private Properties
    
    var loadImageOperation: LoadImageOperation?
    
    // MARK: - IBOutlets
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var cameraLabel: UILabel!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        loadImageOperation?.cancel()
    }
    
    private func updateUI() {
        guard let photo = photo else { return }
        
        if let imageURL = photo.imageURL.usingHTTPS {
            loadImageOperation = LoadImageOperation(url: imageURL, imageView: self.imageView)
        }
        
        descriptionLabel.text = "Taken by \(photo.roverID) on \(photo.earthDate) (Sol \(photo.solNumber))"
        cameraLabel.text = "Camera: \(photo.cameraName)"
    }
    
    @objc func image(image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(
                title: "Error Saving Photo",
                message: error.localizedDescription,
                preferredStyle: .alert
            )
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        } else {
            let ac = UIAlertController(
                title: "Image Saved",
                message: "The image was successfully saved to your photo library.",
                preferredStyle: .alert
            )
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }

    // MARK: - IBActions
    
    @IBAction func saveToPhotoLibrary(_ sender: Any) {
        guard let image = imageView.image else { return }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
}

