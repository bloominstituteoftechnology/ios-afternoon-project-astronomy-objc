//
//  DetailViewController.swift
//  Astronomy - ObjC
//
//  Created by James McDougall on 3/5/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    /// - Properties
    let networkController = LSINetworkController()
    var imageURL: URL? {
        didSet {
            networkController.fetchPhoto(with: imageURL!) { (image, error) in
                if let error = error {
                    print("ERROR: Could not fetch image with URL, reason: \(error)")
                    return
                }
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    var image: UIImage?
    
    /// - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var photoDetailsLabel: UILabel!
    @IBOutlet weak var cameraDetailsLabel: UILabel!
    
    /// - IBActions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
    }
    
    /// - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        networkController.fetchSolTenImage { (imageURL, error) in
            if let error = error {
                print(error)
                return
            }
            self.imageURL = imageURL
        }
    }
    
}
