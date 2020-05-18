//
//  CollectionViewController.swift
//  LYDAstronomyObjC
//
//  Created by Lydia Zhang on 5/18/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MarsCell"

class CollectionViewController: UICollectionViewController {
    let photoController = PhotosController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoController.fetchManifest(fromRover: "curiosity") {data in
            if data != nil {
                DispatchQueue.main.async {
                    
                    self.collectionView.reloadData()
                }
            }
        }
    }


    
    // MARK: - Navigation

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegue(withIdentifier: "DetailSegue", sender: self)
    }
    

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoController.photoArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
    
        return cell
    }

}
