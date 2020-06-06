//
//  PhotosViewController.swift
//  Astronomy-Interoperability
//
//  Created by Christian Lorenzo on 6/3/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    // MARK: - Properties:
    let photoController = PhotoController()
    var hasFinished: Bool = false
    var hasPhotoFinished: Bool = false
    var arrayOfFilters: [Photo] = []
    var sol: Int = 2
    let cache = NSCache<NSNumber, UIImage>()
    let operationsDict: [Int : Operation] = [:]
    let photoFetchQueue = OperationQueue()
    
    // MARK: - Outlets
    @IBOutlet weak var collectonView: UICollectionView!
    @IBOutlet weak var previousSolButton: UIBarButtonItem!
    @IBOutlet weak var nextSolButton: UIBarButtonItem!
    @IBOutlet weak var cameraSegmentedControl: UISegmentedControl!
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraSegmentedControl.isEnabled = false
        previousSolButton.isEnabled = false
        setupSegmentedControl()
        networkRequest()
    }
    
    // MARK: Private Methods
    private func networkRequest() {
        photoController.fetchManifest { error in
            if let error = error {
                print("Error fetching manifest \(error)")
                return
            }
            
            self.hasFinished = true
            
            DispatchQueue.main.async {
                self.collectonView.reloadData()
                self.setupSegmentedControl()
                self.title = "Sol \(Int((self.photoController.manifests[self.sol] as! Manifest).solID))"
            }
            
            self.photoController.fetchSol(by: self.photoController.manifests[self.sol] as! Manifest) { error in
                if let error = error {
                    print("Error fetching manifest \(error)")
                    return
                }
                
                DispatchQueue.main.async {
                    self.collectonView.reloadData()
                    self.hasPhotoFinished = true
                    self.cameraSegmentedControl.isEnabled = true
                }
            }
        }
    }
    
    private func setupSegmentedControl() {
        cameraSegmentedControl.removeAllSegments()
        
        var i = 1
        cameraSegmentedControl.insertSegment(withTitle: "NONE", at: 0, animated: true)
        for item in (photoController.manifests[sol] as! Manifest).cameras {
            cameraSegmentedControl.insertSegment(withTitle: item, at: i, animated: true)
            i += 1
        }
        cameraSegmentedControl.selectedSegmentIndex = 0
    }
    
    private func setupCollectionViewCells() {
        
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            guard let photoVC = segue.destination as? PhotoDetailViewController else { return }
            guard let selected = collectonView.indexPathsForSelectedItems else { return }
            
            if arrayOfFilters.count != 0 {
                photoVC.photo = arrayOfFilters[selected[0].row]
            } else {
                photoVC.photo = (photoController.photos[selected[0].row] as! Photo)
            }
            
            photoVC.photoController = photoController
        }
    }
}
