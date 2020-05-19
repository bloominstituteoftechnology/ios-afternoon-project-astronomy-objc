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
    var fetchOperation: PhotoFetchOperation = PhotoFetchOperation()
    var operations = [Int: Operation]()
    var photoFetchQueue = OperationQueue()
    var sol = 0
    var cache: Cache = Cache<NSString, NSData>()

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

    func fetchPhoto(forCell cell: TMCMarsPhotoCollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoArray[indexPath.item]

        if let imageData = cache.object(byKey: NSString(string: "\(photo.identification)")) as Data? {
            DispatchQueue.main.async {
                if let image = UIImage(data: imageData) {
                    cell.imageView.image = image
                }
            }
        }

        fetchOperation = PhotoFetchOperation(photoReference: photo)

        let cacheOperation = BlockOperation {
            if let data = self.fetchOperation.imageData {
                self.cache.cache(NSData(data: data), forKey: NSString(string: "\(photo.identification)"))
            }
        }

        let completionOperation = BlockOperation {
            if let _ = self.collectionView.indexPath(for: cell) {
                if let data = self.fetchOperation.imageData {
                    cell.imageView.image = UIImage(data: data)
                } else {
                    return
                }
            }
        }

        cacheOperation.addDependency(fetchOperation)
        completionOperation.addDependency(fetchOperation)

        photoFetchQueue.addOperations([fetchOperation, cacheOperation], waitUntilFinished: false)

        OperationQueue.main.addOperation(completionOperation)
        operations[photo.identification.intValue] = fetchOperation
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
        fetchPhoto(forCell: cell, forItemAt: indexPath)

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
