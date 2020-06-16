//
//  PhotoCollectionViewController.swift
//  Astronomy-ObjcSwift
//
//  Created by Hunter Oppel on 6/15/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PhotoCell"

class PhotoCollectionViewController: UICollectionViewController {
    
    private let photoFetcher = PhotoFetcher()
    private var photos = [Photo]()
    
    private lazy var manifestFetcher = ManifestFetcher()
    private var sols = [NSNumber]()
    private var selectedSol: NSNumber?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manifestFetcher.fetchManifest { sols, error in
            if let error = error {
                NSLog("Failed to fetch manifest with error: \(error)")
                return
            }
            
            guard let sols = sols,
                sols.count > 0 else {
                NSLog("Sols array was bad")
                return
            }
            
            DispatchQueue.main.async {
                self.sols = sols
                self.selectedSol = sols.first
                self.updateViews()
            }
        }
        
    }
    
    private func updateViews() {
        guard let selectedSol = selectedSol else { return }
        
        print(selectedSol.intValue)
        
        self.title = "Sol \(selectedSol.intValue)"
        fetchPhotosForSol(sol: selectedSol)
    }
    
    private func fetchPhotosForSol(sol: NSNumber) {
        photoFetcher.fetchPhotos(fromSol: sol) { (photos, error) in
            if let error = error {
                NSLog("Error fetching photos from sol 1: \(error)")
                return
            }
            
            guard let photos = photos,
                photos.count > 0 else {
                    NSLog("No photos returned from fetch")
                    return
            }
            
            self.photos = photos
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
     // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewPhotoSegue" {
            guard let detailVC = segue.destination as? PhotoDetailViewController,
                let cell = sender as? PhotoCollectionViewCell,
                let indexPath = collectionView.indexPath(for: cell) else { return }
            detailVC.photo = photos[indexPath.row]
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else { fatalError() }
        
        cell.photo = photos[indexPath.row]
        
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
