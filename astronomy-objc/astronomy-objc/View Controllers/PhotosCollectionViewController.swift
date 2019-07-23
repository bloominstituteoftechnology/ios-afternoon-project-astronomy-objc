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
	var solController: SolController?

	override func viewDidLoad() {
		super.viewDidLoad()
		
		collectionView.dataSource = self
		collectionView.delegate = self
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if let solNumber = solNumber {
			
			NSLog("SolNumber: \(solNumber)")
			
			solController?.fetchSolImageList(withSol: Int32(solNumber), completion: { error in
				if let error = error { print(error) }
			})
		}
		
	}


}




extension PhotosCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanetCell", for: indexPath)
		return cell
	}
	
	
}
