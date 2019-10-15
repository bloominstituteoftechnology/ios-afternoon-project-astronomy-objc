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
	
	var photoURL: URL? {
		didSet {
			updateViews()
		}
	}
	var roverController: RoverController?

	private func updateViews() {
		loadViewIfNeeded()
		guard let url = photoURL else { return }

		if let cachedData = roverController?.cache.item(forKey: url.absoluteString) {
			let image = UIImage(data: cachedData)
			DispatchQueue.main.async {
				self.imageView.image = image
			}
			return
		}

		URLSession.shared.dataTask(with: url) { (imageData, response, error) in
			if let error = error {
				NSLog("Error loading image: \(error)")
				return
			}

			guard let imageData = imageData else { return }
			self.roverController?.cache.cacheItem(withKey: url.absoluteString, item: imageData)
			let image = UIImage(data: imageData)
			DispatchQueue.main.async {
				self.imageView.image = image
			}
		}.resume()
	}

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
