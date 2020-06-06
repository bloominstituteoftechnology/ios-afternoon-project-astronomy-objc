//
//  PhotoDetailViewController.swift
//  Astronomy-Interoperability
//
//  Created by Christian Lorenzo on 6/3/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

import UIKit
import Photos

class PhotoDetailViewController: UIViewController {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var roverLabel: UILabel!
    @IBOutlet weak var solLabel: UILabel!    
    @IBOutlet weak var cameraLabel: UILabel!
    
    var photoController: PhotoController?
    var photo: Photo? {
        didSet {
            updateViews()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        setupViews()

        // Do any additional setup after loading the view.
    }
    
    private func setupViews() {
        saveButton.layer.cornerRadius = 8
        backgroundView.layer.cornerRadius = 8
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOpacity = 2
        backgroundView.layer.shadowOffset = .zero
        backgroundView.layer.shadowRadius = 8
        backgroundView.layer.masksToBounds = false
        backgroundView.backgroundColor = UIColor.white
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        guard let photo = photo else { return }
        
        photoController?.fetchingSinglePhoto(with: photo.imgSrc, completionBlock: { error, image in
            if let error = error {
                print("Error fetching image \(error)")
            }
            
            if let image = image {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        })
        
        cameraLabel.text = photo.cameraName
        roverLabel.text = "\(photo.roverID)"
        dateLabel.text = "\(photo.photoDate)"
        solLabel.text = "\(photo.sol)"
    }
    
    private func savePhoto(with image: UIImage) {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAsset(from: image)
                }, completionHandler: { succes, error in
                    if let error = error {
                        print("Error saving photo: \(error)")
                        return
                    }
                    
                    if succes {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Success", message: nil, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                })
                
            default:
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Cannot save image", message: "We do not have access to your photo library. Please change this in the settings if you would like to save images.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                break
            }
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let image = imageView.image else { return }
        savePhoto(with: image)
    }
}
