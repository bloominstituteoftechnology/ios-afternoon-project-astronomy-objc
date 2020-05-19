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

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        
    }

    func updateViews() {
        guard let photoReference = photoReferernce else { return }

        guard let imageURL = photoReference.imageURL.usingHTTPS,
            let dataImage = try? Data(contentsOf: imageURL),
            let date = photoReferernce?.earthDate else { return }

        roverImage.image = UIImage(data: dataImage)
        dateLabel.text = "Taken by \(photoReference.identification) on \(date) (Sol \(photoReference.sol))"
        cameraLabel.text = "Camera: \(photoReference.camera.capitalized) Camera"
    }
}
