//
//  PhotoDetailViewController.swift
//  AstronomyObjC
//
//  Created by Chris Gonzales on 4/20/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var photoDescriptionLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    
    @IBAction func saveTapped(_ sender: UIButton) {
        
    }
    
}
