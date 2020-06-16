//
//  PhotoDetailViewController.swift
//  Obj-C-Astronomy
//
//  Created by Patrick Millet on 6/16/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

import UIKit
import Photos

class PhotoDetailViewController: UIViewController {
    
    @IBOutlet weak var marsRoverImage: UIImageView!
    @IBOutlet weak var photoDetailsLabel: UILabel!
    @IBOutlet weak var cameraDetailsLabel: UILabel!
    @IBOutlet weak var savePhotoButton: UIButton!
    
    
    var marsRoverPhoto: MarsRoverPhoto?
    var imageData: Data?
    var image: UIImage?
    
    
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
        self.image = image
    }
    
    
    func savePhotoToLibrary(image: UIImage) {
        PHPhotoLibrary.requestAuthorization { (status) in
            guard status == .authorized else { return }
            
            // TODO: - Send user to settings to get permission
            
            PHPhotoLibrary.shared().performChanges({
                PHAssetCreationRequest.creationRequestForAsset(from: image)
            }) { (success, error) in
                if let error = error {
                    print("Error saving photo: \(error)")
                    return
                }
                
                DispatchQueue.main.async {
                    self.presentSuccessfulSaveAlert()
                }
            }
        }
    }
    
    private func presentSuccessfulSaveAlert() {
        let alert = UIAlertController(title: "Photo Saved!", message: "The photo has been saved to your Photo Library!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func presentImagePickerController() {
        
        //TODO: - Check for restrictions on photo accessibility and present UI
        
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("The photo library is not available")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    // MARK: - Actions
    
    @IBAction func savePhotoTapped(_ sender: Any) {
        guard let image = image else { return }
        savePhotoToLibrary(image: image)
    }
    
    
    @IBAction func openPhotosTapped(_ sender: Any) {
        self.presentImagePickerController()
    }
    
}



extension PhotoDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
