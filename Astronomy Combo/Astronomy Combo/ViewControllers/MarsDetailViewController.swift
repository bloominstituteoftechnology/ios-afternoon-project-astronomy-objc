//
//  MarsDetailViewController.swift
//  Astronomy Combo
//
//  Created by Michael Redig on 10/14/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import UIKit

class MarsDetailViewController: UIViewController {

	@IBOutlet weak var imageView: UIImageView!
	
	var photoURL: URL?
	var roverController: RoverController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
