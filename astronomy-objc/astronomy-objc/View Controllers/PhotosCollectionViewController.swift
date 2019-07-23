//
//  PhotosCollectionViewController.swift
//  astronomy-objc
//
//  Created by Hector Steven on 7/22/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit


class PhotosCollectionViewController: UIViewController {
	let solController = SolController()
	
	
	@IBOutlet var collectionView: UICollectionView!
	override func viewDidLoad() {
		super.viewDidLoad()
		
		collectionView.dataSource = self
		collectionView.delegate = self
		
		solController.fetchSols { (error) in
			if let error = error {
				print("Error: \(error)")
			}
		}
		
		
		
	}
}

extension PhotosCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanetCell", for: indexPath)
		return cell
	}
	
	
}
