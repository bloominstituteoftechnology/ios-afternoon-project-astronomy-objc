//
//  DetailViewController.swift
//  Astronomy-objc
//
//  Created by Bradley Yin on 10/14/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var solLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var earthDateLabel: UILabel!
    
    var photoReference: BYMarsPhotoReference?
    var photo: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
    }
    private func updateViews() {
        guard let photoReference = photoReference, isViewLoaded, let photo = photo else { return }
        solLabel.text = "Sol: " + photoReference.sol.stringValue
        imageView.image = photo
        cameraLabel.text = "Camera: " + photoReference.camera.fullName
        print(photoReference.camera.name)
        earthDateLabel.text = "Earth date: " + photoReference.earthDate
    }



}
