//
//  MainCollectionViewController.swift
//  Astronomy-objc
//
//  Created by Matthew Martindale on 8/5/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

import UIKit


class MainCollectionViewController: UICollectionViewController {
    
    let manifestController = FetchManifest()
    var marsPhotos: [MarsPhotoReference] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let rover = "curiosity"
        manifestController.fetchRoverManifest(rover) { (rover, error) in
            guard error == nil else {
                print("Error fetching rover manifest in VC: \(error!)")
                return
            }
            if let rover = rover {
                self.manifestController.fetchPhotos(from: rover, onSol: 10) { (photos, error) in
                    if let photos = photos {
                        DispatchQueue.main.async {
                            self.marsPhotos = photos
                        }
                    }
                }
            }
        }

        // Do any additional setup after loading the view.
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return marsPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
    
        cell.marsPhoto = marsPhotos[indexPath.row]
    
        return cell
    }


}

extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var totalUsableWidth = collectionView.frame.width
        let inset = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
        totalUsableWidth -= inset.left + inset.right
        
        let minWidth: CGFloat = 150.0
        let numberOfItemsInOneRow = Int(totalUsableWidth / minWidth)
        totalUsableWidth -= CGFloat(numberOfItemsInOneRow - 1) * 10.0
        let width = totalUsableWidth / CGFloat(numberOfItemsInOneRow)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 10.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10.0
    }
}
