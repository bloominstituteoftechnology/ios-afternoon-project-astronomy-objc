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

    //MARK: - Properties
    var photoArray: [TMCMarsPhotoReference] = []
    let networkController:NetworkController = NetworkController()
    let fetchOperation: PhotoFetchOperation = PhotoFetchOperation()
    var sol = 0

    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchManifest()
    }

    func updateViews() {
        title = "Sol \(sol)"
    }



    //MARK: - Actiona Methods
    @IBAction func previousSolTapped(_ sender: Any) {
        if sol > 0 {
            sol -= 1
            fetchManifest()
        } else {
            return
        }
    }
    @IBAction func nextSolTapped(_ sender: Any) {
        sol += 1
        fetchManifest()
    }

    // MARK: - Helper Methods
    func fetchManifest() {
        networkController.fetchMarsPhotos(onSol: NSNumber(integerLiteral: sol)) { (photos, error) in
            if error != nil {
                NSLog(String(describing: error))
                return
            }
            if photos != nil {
                self.photoArray = photos!
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.updateViews()
                }
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PhotoDetailSegue" {
            if let photoDetailVC = segue.destination as? DetailViewController {
                let cell = sender as! TMCMarsPhotoCollectionViewCell
                let indexPath = self.collectionView!.indexPath(for: cell)
                let photoReference = photoArray[indexPath!.item]
                photoDetailVC.photoReferernce = photoReference
                photoDetailVC.networkController = networkController
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
        let photoReference = photoArray[indexPath.item]
        networkController.fetchImage(for: photoReference) { (data, error) in
            DispatchQueue.main.async {
                guard let data = data else {return}
                cell.imageView.image = UIImage(data: data)
            }
        }

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


//    private func loadImage(forCell cell: TMCMarsPhotoCollectionViewCell, forItemAt indexPath: IndexPath) {
//        let photo = photoArray[indexPath.item]
//        guard let url = photo.imageURL.usingHTTPS else { return }
//
//        URLSession.shared.dataTask(with: url) { (data,_,error) in
//            if let error = error {
//                NSLog("load image error: \(error)")
//                return
//            }
//
//            guard let data = data else {return}
//
//            DispatchQueue.main.async {
//                let currentIndex = self.collectionView.indexPath(for: cell)
//                guard currentIndex == indexPath else {return}
//                cell.imageView.image = UIImage(data: data)
//            }
//
//        }.resume()
//    }
