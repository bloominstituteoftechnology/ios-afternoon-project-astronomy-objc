//
//  PhotosCollectionViewController.swift
//  astronomy-objc
//
//  Created by Hector Steven on 7/22/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit


class PhotosCollectionViewController: UIViewController {
	@IBOutlet var collectionView: UICollectionView!
	
	var solNumber: Int?
	let solImageListController = SolImageListController()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		collectionView.dataSource = self
		collectionView.delegate = self
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if let solNumber = solNumber {
			
			NSLog("SolNumber: \(solNumber)")
			
			
//
//			solImageListController.fetchImageList(withSol: Int32(solNumber) ) { (_) in
//
//				DispatchQueue.main.async {
//					self.collectionView.reloadData()
//				}
//			}
		}
		
	}
}

extension PhotosCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return solImageListController.solImageList()?.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanetCell", for: indexPath)
		
		
		return cell
	}
	
	
}
