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
		let controller = RoverController()
		controller.delegate = self
		return controller;
	}()


}

extension MarsCollectionViewController: REPRoverControllerDelegate {
	func roverControllerLoadedData(_ controller: RoverController) {
		DispatchQueue.main.async {
			self.collectionView.reloadData()
		}
	}
}
