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
        collectionView.delegate = self
        collectionView.dataSource = self
        photoController.fetchPhotos(fromRover: "curiosity", sol: 30) {result in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    // Make collection view cells fill as much available width as possible

    private func loadImage(forCell cell: CollectionViewCell, forItemAt indexPath: IndexPath) {
            
        let photo = photoController.photoArray[indexPath.item]
        guard let url = photo.imageURL else {return}
        URLSession.shared.dataTask(with: url) { (data,_,error) in
                if let error = error {
                    NSLog("load image error: \(error)")
                    return
                }
                guard let data = data else {return}
    
                DispatchQueue.main.async {
                    let currentIndex = self.collectionView.indexPath(for: cell)
                    guard currentIndex == indexPath else {return}
                    cell.imageView.image = UIImage(data: data)
                }
    
        }.resume()
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
        
        loadImage(forCell: cell as! CollectionViewCell, forItemAt: indexPath)
        return cell
    }

}
