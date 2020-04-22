//
//  DetailViewController.swift
//  Astronomy - ObjC
//
//  Created by Ufuk Türközü on 20.04.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import UIKit
import Photos

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    var apiController = APIController()
    
    var photo: UFOMarsPhoto? {
        didSet {
            updateViews()
        }
    }
    
    lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        return df
    }()

    @IBOutlet weak var solPhotoIV: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        apiController.fetchPhoto(withRoverName: "curiosity", sol: 1000) { (photos) in
            self.photo = photos.last
        }
    }
    
    @IBAction func save(_ sender: Any) {
        guard let image = solPhotoIV.image else { return }
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }, completionHandler: { (success, error) in
            if let error = error {
                NSLog("Error saving photo: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.successfulSaveAlert()
            }
        })
    }
    
    func successfulSaveAlert() {
        let alert = UIAlertController(title: "Photo Saved!", message: "Saved to your Photo Library!", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alert.addAction(okayAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func updateViews() {
        guard let photo = photo, isViewLoaded else { return }
        do {
            let data = try Data(contentsOf: photo.imgSrc.usingHTTPS!)
            solPhotoIV.image = UIImage(data: data)
            let dateString = dateFormatter.string(from: photo.earthDate)
            detailLabel.text = "Taken by \(photo.camera.roverId) on \(dateString) (Sol \(photo.sol))"
            cameraLabel.text = photo.camera.fullName
        } catch {
            NSLog("Error setting up views on detail view controller: \(error)")
        }
    }

}
