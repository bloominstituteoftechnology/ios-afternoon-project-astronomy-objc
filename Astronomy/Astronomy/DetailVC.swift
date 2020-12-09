//
//  DetailVC.swift
//  Astronomy
//
//  Created by Cora Jacobson on 12/9/20.
//

import UIKit
import Photos

class DetailVC: UIViewController {

    @IBOutlet private var detailLabel: UILabel!
    @IBOutlet private var cameraLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    
    var photo: MarsPhoto? {
        didSet {
            updateViews()
        }
    }
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func savePhoto(_ sender: UIButton) {
        guard let image = imageView.image else { return }
        PHPhotoLibrary.shared().performChanges {
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        } completionHandler: { (success, error) in
            if let error = error {
                NSLog("Error saving photo: \(error)")
                return
            }
        }

    }
    
    private func updateViews() {
        guard let photo = photo, isViewLoaded else { return }
        do {
            let data = try Data(contentsOf: photo.imageURL.usingHTTPS!)
            imageView.image = UIImage(data: data)
            let dateString = dateFormatter.string(from: photo.earthDate)
            detailLabel.text = "Taken by \(photo.camera.roverID) on \(dateString) (Sol \(photo.sol)"
            cameraLabel.text = "Camera: \(photo.camera.fullName)"
        } catch {
            NSLog("Error setting up views: \(error)")
        }
    }
        
}
