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
    var roverPhoto: RoverPhoto?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let roverToFetch: String = "curiosity"
        let solToFetch: Int = 12
        
        photoController.fetchRoverPhotos(roverToFetch, Int32(solToFetch)) { (data, error) in
            guard let data = data else {
                NSLog("Error returned fetching Rover photos\(error!)")
                return }
            
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
            
            DispatchQueue.main.async {
                do {
                    let earthDateLong: Date = dateFormatter.date(from: String("\(data.roverPhotos[31].earthDate)"))!
                    let earthDateString: String = dateFormatterString.string(from: earthDateLong)
                    
                    let photoData = try Data(contentsOf: data.roverPhotos[31].photoURL) // FIXME: Hard-coded a photo by index number
                    self.roverPhotoImage.image = UIImage(data: photoData)
                    
                    self.roverNameTextLabel.text = String("Rover - \(roverToFetch.capitalized)")
                    self.solTextLabel.text = String("Mission Sol: \(solToFetch)")
                    self.photoIDTextLabel.text = String("Photo ID: \(data.roverPhotos[31].photoID)")
                    self.earthDateTextLabel.text = String("Earth Date: \(earthDateString)")
                    self.cameraNameTextLabel.text = data.roverPhotos[31].cameraName
                } catch {
                    NSLog("Error setting up views on detail view controller: \(error)")
                }
            }
            return
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
