//
//  RoverCollectionViewController.swift
//  Astronomy in OBJC
//
//  Created by Sal B Amer on 6/4/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

import UIKit

private let reuseIdentifier = "RoverPicsCell"

class RoverCollectionViewController: UICollectionViewController {
  
  //MARK Properties
  
  var cache: Cache = Cache<NSString, NSData>()
  var sol = 0
  var photoArray: [MarsPhotos] = []
  let roverAPiController: RoverAPIController = RoverAPIController()
  var fetchOperations: FetchOperations = FetchOperations()
  var operations = [Int: Operation]()
  var photosGettingFetched = OperationQueue()
  
  func updateViews() {
    title = "Sol \(sol)"
  }


    override func viewDidLoad() {
        super.viewDidLoad()
        fetchManifest()
//
//        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "DetailViewSegue" {
        if let detailVC = segue.destination as? RoverDetailViewController {
            let cell = sender as! RoverCollectionViewCell
            let indexPath = self.collectionView!.indexPath(for: cell)
            let photoReference = photoArray[indexPath!.item]
            detailVC.marsPhotoRef = photoReference
            detailVC.roverAPIController = roverAPiController
            
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RoverCollectionViewCell
        fetchPhotos(forCell: cell, forItemAt: indexPath)
    
        return cell
    }
  
  //ACTIONS
  @IBAction func previousSolBtnPressed(_ sender: UIBarButtonItem) {
    if sol > 0 {
        sol -= 1
        fetchManifest()
    } else {
        return
    }
  }
  
  @IBAction func nextSolBtnWasPressed(_ sender: UIBarButtonItem) {
    sol += 1
          fetchManifest()
  }
  
  //HELPERS
  
  func fetchManifest() {
    roverAPiController.fetchMarsPhotos(fromSol: NSNumber(integerLiteral: sol)) { (photos, error) in
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
  
  func fetchPhotos(forCell cell: RoverCollectionViewCell, forItemAt indexPath: IndexPath) {
    let photo = photoArray[indexPath.item]
    if let imageData = cache.object(byKey: NSString(string: "\(photo.identification)")) as Data? {
      DispatchQueue.main.async {
        if let image = UIImage(data: imageData){
          cell.imageView?.image = image
        }
      }
    }
    fetchOperations = FetchOperations(photoReference: photo)
    
    let cacheOperation = BlockOperation {
      if let data = self.fetchOperations.imageData {
        self.cache.cache(NSData(data: data), forKey: NSString(string: "\(photo.identification)"))
      }
    }
    let completionOperation = BlockOperation {
      if let _ = self.collectionView.indexPath(for: cell) {
        if let data = self.fetchOperations.imageData {
          cell.imageView?.image = UIImage(data: data)
        } else {
          return
        }
      }
    }
    cacheOperation.addDependency(fetchOperations)
    completionOperation.addDependency(fetchOperations)
    
    photosGettingFetched.addOperations([fetchOperations, cacheOperation], waitUntilFinished: false)
    OperationQueue.main.addOperation(completionOperation)
    operations[photo.identification.intValue] = fetchOperations
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
    var usingSHTTPS: URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else { return nil }
        components.scheme = "https"
        return components.url
    }
}
