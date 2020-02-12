//
//  PhotoDetailViewController.swift
//  Astronomy-Hybrid
//
//  Created by Bobby Keffury on 2/12/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit
import Photos

class PhotoDetailViewController: UIViewController {
    
    //MARK: - Properties

    //MISSING PHOTO VAR
    
    lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        return df
    }()
    
    //MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    
    //MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Methods
    
    private func updateViews() {
        //FINISH THIS WHEN PHOTO GETS INPUT
    }
    
    func presentSuccessfulSaveAlert() {
        let alert = UIAlertController(title: "Photo Saved!", message: "The photo has been saved to your Photo Library!", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alert.addAction(okayAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let image = imageView.image else { return }
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }) { (success, error) in
            if let error = error {
                NSLog("Error saving photo: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.presentSuccessfulSaveAlert()
            }
        }
    }

}
