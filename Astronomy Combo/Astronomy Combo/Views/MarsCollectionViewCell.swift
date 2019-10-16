//
//  MarsCollectionViewCell.swift
//  Astronomy Combo
//
//  Created by Michael Redig on 10/14/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import UIKit

class MarsCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var imageView: UIImageView!
	var photoURL: URL? {
		didSet {
			updateViews()
		}
	}
	var roverController: RoverController?

	private var networkLoadOperation: NetworkLoadOperation?

	override func prepareForReuse() {
		super.prepareForReuse()
		imageView.image = nil
	}

	func cancelLoad() {
		networkLoadOperation?.cancel()
		networkLoadOperation = nil
	}

	private func updateViews() {
		loadImage()
	}

	private func loadImage() {
		if let url = photoURL {
			cancelLoad()
			if let cachedData = roverController?.cache.item(forKey: url.absoluteString) {
				let image = UIImage(data: cachedData)
				DispatchQueue.main.async {
					self.imageView.image = image
				}
				NSLog("loaded from cache")
				return
			}

			let netOp = NetworkLoadOperation(url: url)
			let cacheOp = BlockOperation {// [weak self] in
				NSLog("cache run")
				if let imageData = self.networkLoadOperation?.loadedData {
					self.roverController?.cache.cacheItem(withKey: url.absoluteString, item: imageData)
				}
			}
			let completionOp = BlockOperation {// [weak self] in
				NSLog("completion run")
				if let imageData = self.networkLoadOperation?.loadedData {
					self.imageView.image = UIImage(data: imageData)
					NSLog("loaded from net")
				}
			}

			networkLoadOperation = netOp
			cacheOp.addDependency(netOp)
			completionOp.addDependency(netOp)

			roverController?.fetchQueue.addOperation(netOp)
			roverController?.fetchQueue.addOperation(cacheOp)
			OperationQueue.main.addOperation(completionOp)
//			netOp.start()
		}
	}
}
