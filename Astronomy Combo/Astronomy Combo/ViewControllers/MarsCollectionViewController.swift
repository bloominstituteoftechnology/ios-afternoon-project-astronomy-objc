//
//  MarsCollectionViewController.swift
//  Astronomy Combo
//
//  Created by Michael Redig on 10/14/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import UIKit

class MarsCollectionViewController: UICollectionViewController {

	lazy var roverController: RoverController = {
		let controller = RoverController(roverNamed: "Curiosity")
		controller.delegate = self
		return controller;
	}()
}

extension MarsCollectionViewController {

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return roverController.currentSolPhotos.count
	}

	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)

		return cell
	}

}

extension MarsCollectionViewController: REPRoverControllerDelegate {
	func roverControllerLoadedData(_ controller: RoverController) {
		DispatchQueue.main.async {
			self.collectionView.reloadData()
		}
	}
}
