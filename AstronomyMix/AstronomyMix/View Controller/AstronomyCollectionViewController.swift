//
//  AstronomyCollectionViewController.swift
//  AstronomyMix
//
//  Created by Jorge Alvarez on 3/23/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class AstronomyCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    let apiController = APIController()

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(apiController.solPhotos.count)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apiController.solPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! JLAAstronomyCollectionViewCell
    
        let rover = apiController.solPhotos[indexPath.row]
        cell.imageView.image = UIImage(named: "park")
        
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailSegue" {
            print("DetailSegue")
        }
    }
}
