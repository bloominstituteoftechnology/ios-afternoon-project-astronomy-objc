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
			
			solController?.fetchImageList(withSol: Int32(solNumber), completion: { _ in
				print("received")
				DispatchQueue.main.async {
					self.collectionView.reloadData()
				}
			})
			
			
		}
	}
}

extension PhotosCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return  solController?.solPhotosDescription()?.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanetCell", for: indexPath) as? PhotosCollectionCell,
			let solPhoto = solController?.solPhotosDescription()[indexPath.row] as? SolPhotoDescription else { return  UICollectionViewCell()}
		let url = URL(string: solPhoto.img_src)
		
		solController?.fetchImage(with: url, completion: { (data, error) in
			if let error = error {
				print(error)
			}
			
			if let data = data {
				DispatchQueue.main.async {
					cell.imageView.image = UIImage(data: data)
				}
		}
		})
		return cell
	}
	
	
}
