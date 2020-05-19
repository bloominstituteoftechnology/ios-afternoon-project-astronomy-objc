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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photoArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarsCell", for: indexPath) as! TMCMarsPhotoCollectionViewCell
    
        loadImage(forCell: cell, forItemAt: indexPath)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension URL {
    var usingHTTPS: URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else { return nil }
        components.scheme = "https"
        return components.url
    }
}
