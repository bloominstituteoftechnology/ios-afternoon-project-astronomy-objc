//
//  MarsPhotosCollectionViewController.swift
//  AstronomyObjC
//
//  Created by Christopher Devito on 5/18/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MarsPhotosCollectionViewController: UICollectionViewController {
    var photoArray: [TMCMarsPhotoReference] = []
    let networkController:NetworkController = NetworkController()

    override func viewDidLoad() {
        super.viewDidLoad()
        networkController.fetchMarsPhotos(onSol: 1000) { (photos, error) in
            if error != nil {
                NSLog(String(describing: error))
                return
            }
            if photos != nil {
                self.photoArray = photos!
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }

    private func loadImage(forCell cell: TMCMarsPhotoCollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoArray[indexPath.item]
        guard let url = photo.imageURL.usingHTTPS else { return }

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PhotoDetailSegue" {
            if let photoDetailVC = segue.destination as? DetailViewController {
                let cell = sender as! TMCMarsPhotoCollectionViewCell
                let indexPath = self.collectionView!.indexPath(for: cell)
                let photoReference = photoArray[indexPath!.item]
                photoDetailVC.photoReferernce = photoReference
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarsCell", for: indexPath) as! TMCMarsPhotoCollectionViewCell
    
        loadImage(forCell: cell, forItemAt: indexPath)
    
        return cell
    }
}

extension URL {
    var usingHTTPS: URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else { return nil }
        components.scheme = "https"
        return components.url
    }
}
