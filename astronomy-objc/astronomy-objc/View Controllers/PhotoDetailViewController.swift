//
//  PhotoDetailViewController.swift
//  astronomy-objc
//
//  Created by Hector Steven on 7/22/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
//		updateViews()
	}
	
	@IBAction func save(_ sender: Any) {
		guard let image = imageView.image else { return }
//		PHPhotoLibrary.shared().performChanges({
//			PHAssetChangeRequest.creationRequestForAsset(from: image)
//		}, completionHandler: { (success, error) in
//			if let error = error {
//				NSLog("Error saving photo: \(error)")
//				return
//			}
//			DispatchQueue.main.async {
//				self.presentSuccessfulSaveAlert()
//			}
//		})
	}
	
//	func presentSuccessfulSaveAlert() {
//		let alert = UIAlertController(title: "Photo Saved!", message: "The photo has been saved to your Photo Library!", preferredStyle: .alert)
//
//		let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
//		okayAction.accessibilityLabel = "SaveOkay Label"
//		alert.addAction(okayAction)
//
//		present(alert, animated: true, completion: nil)
//	}
	
	// MARK: - Private
	
//	private func updateViews() {
//		guard let photo = photo, isViewLoaded else { return }
//		title = "\(photo.id)"
//
//		do {
//			let data = try Data(contentsOf: photo.imageURL.usingHTTPS!)
//			imageView.image = UIImage(data: data) //?.filtered()
//			let dateString = dateFormatter.string(from: photo.earthDate)
//			detailLabel.text = "Taken by \(photo.camera.roverId) on \(dateString) (Sol \(photo.sol))"
//			cameraLabel.text = photo.camera.fullName
//		} catch {
//			NSLog("Error setting up views on detail view controller: \(error)")
//		}
//	}
	
	// MARK: - Properties
	
//	var photo: MarsPhotoReference? {
//		didSet {
//			updateViews()
//		}
//	}
	
//	lazy var dateFormatter: DateFormatter = {
//		let df = DateFormatter()
//		df.dateStyle = .short
//		df.timeStyle = .short
//		return df
//	}()
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var detailLabel: UILabel!
	@IBOutlet weak var cameraLabel: UILabel!
	
}
