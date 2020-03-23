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

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailSegue" {
            print("DetailSegue")
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

}
