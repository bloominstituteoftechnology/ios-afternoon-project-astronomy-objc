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
	@IBOutlet weak var scrollView: UIScrollView!

	var photoURL: URL? {
		didSet {
			updateViews()
		}
	}
	var roverController: RoverController?

	private func updateViews() {
		navigationItem.title = "Mars Image"
		loadViewIfNeeded()

		scrollView.minimumZoomScale = 1
		scrollView.maximumZoomScale = 10

		guard let url = photoURL else { return }

		if let cachedData = roverController?.cache.item(forKey: url.absoluteString) {
			let image = UIImage(data: cachedData)
			DispatchQueue.main.async {
				self.imageView.image = image
				self.navigationItem.title = "Mars Image: \(image?.size.width ?? 0) x \(image?.size.height ?? 0)"
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
				self.navigationItem.title = "Mars Image: \(image?.size.width ?? 0) x \(image?.size.height ?? 0)"
			}
		}.resume()
	}

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MarsDetailViewController: UIScrollViewDelegate {
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imageView
	}
}
