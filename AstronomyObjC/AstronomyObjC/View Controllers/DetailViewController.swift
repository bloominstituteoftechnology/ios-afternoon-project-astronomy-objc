//
//  DetailViewController.swift
//  AstronomyObjC
//
//  Created by Christopher Devito on 5/18/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var roverImage: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var cameraLabel: UILabel!

    var photoReferernce: TMCMarsPhotoReference?
    var networkController: NetworkController?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        
    }

    func updateViews() {
        guard let photoReference = photoReferernce,
            let date = photoReferernce?.earthDate,
            let networkController = networkController else { return }

        networkController.fetchImage(for: photoReference) { (data, error) in
            DispatchQueue.main.async {
                guard let data = data else {return}
                self.roverImage.image = UIImage(data: data)
            }
        }

        dateLabel.text = "Taken by \(photoReference.identification) on \(date) (Sol \(photoReference.sol))"
        cameraLabel.text = "Camera: \(photoReference.camera.capitalized) Camera"
    }
}
