//
//  RoverPhotoDetailViewController.swift
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/20/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

import UIKit
import Photos

class RoverPhotoDetailViewController: UIViewController {

    @IBOutlet var roverPhotoImage: UIImageView!
    @IBOutlet var roverNameTextLabel: UILabel!
    @IBOutlet var photoIDTextLabel: UILabel!
    @IBOutlet var solTextLabel: UILabel!
    @IBOutlet var earthDateTextLabel: UILabel!
    @IBOutlet var cameraNameTextLabel: UILabel!
    
    
    var photoController: PhotoController?
    var roverPhoto: RoverPhoto? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    private func updateViews() {
        var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
            return formatter
        }
        var dateFormatterString: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }
        
        guard let roverPhoto = roverPhoto, isViewLoaded else { return }
        do {
            let photoData = try Data(contentsOf: roverPhoto.photoURL)
            roverPhotoImage.image = UIImage(data: photoData)
            let earthDateLong: Date = dateFormatter.date(from: String("\(roverPhoto.earthDate)"))!
            let earthDateString: String = dateFormatterString.string(from: earthDateLong)
            self.roverNameTextLabel.text = String("Rover - Curiosity")
            self.solTextLabel.text = String("Mission Sol: \(roverPhoto.sol)")
            self.photoIDTextLabel.text = String("Photo ID: \(roverPhoto.photoID)")
            self.earthDateTextLabel.text = String("Earth Date: \(earthDateString)")
            self.cameraNameTextLabel.text = roverPhoto.cameraName
        } catch {
            NSLog("Error setting up view on detailVC: \(error)")
        }
    }
    
    @IBAction func savePhotoToLibrary(_ sender: UIButton) {
        guard let image = roverPhotoImage.image else { return }
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }) { (success, possibleError) in
            if let error = possibleError {
                NSLog("Error saving photo: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.presentSuccessfulSaveAlert()
            }
        }
    }
    
    func presentSuccessfulSaveAlert() {
        let alert = UIAlertController(title: "Photo Saved", message: "The Mars rover photo", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
}
