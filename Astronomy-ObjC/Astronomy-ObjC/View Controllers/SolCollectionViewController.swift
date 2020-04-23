//
//  SolCollectionViewController.swift
//  Astronomy-ObjC
//
//  Created by scott harris on 4/21/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SolCollectionViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var solIdLabel: UILabel!
    @IBOutlet weak var titleView: UIStackView!
    
    let apiClient = SAHApiClient();
    let photoFetchQueue = OperationQueue()
    private var solIndex = 0;
    
    
    var manifest: SAHNasaManifest?
    var currentSol: SAHSol? {
        didSet {
           getPhotosForSol()
        }
    }
    
    var photos: [SAHSolPhoto]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = titleView
        collectionView.dataSource = self
        collectionView.delegate = self;
        apiClient.fetchManifest { (manifest, error) in
            if let error = error {
                print("Error fetching manifest: \(error)")
                return
            }
            guard let manifest = manifest else { return }
            self.manifest = manifest
            self.currentSol = manifest.sols[self.solIndex]
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
  
    }
    
    private func updateViews() {
        if let sol = currentSol {
            solIdLabel.text = "Sol \(sol.identifier)"
        }
    }
    
    private func getPhotosForSol() {
        guard let manifest = manifest, let sol = currentSol else { return }
        let identifier = NSNumber(value: sol.identifier)
        apiClient.fetchSolPhotos(forRover: manifest.name, solId: identifier) { (photos, error) in
            if let error = error {
                print("Error fetching photos: \(error)")
                return
            }
            
            guard let photos = photos else { return }
            
            DispatchQueue.main.async {
                self.photos = photos
            }
            
        }
    }
    
    private func loadImage(for cell: SolPhotoCollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let photo = photos?[indexPath.item] else { return }
        
        let loadOp = SAHFetchPhotoOperation(solPhoto: photo)
        
        let cellReuseOperation = BlockOperation {
            cell.imageView.image = UIImage(data: loadOp.imageData)
        }
        
        cellReuseOperation.addDependency(loadOp)
        photoFetchQueue.addOperations([loadOp], waitUntilFinished: false)
        OperationQueue.main.addOperation(cellReuseOperation)
        
    }
    
    
    @IBAction func previousTapped(_ sender: Any) {
        if solIndex < 1 {
            solIndex = 0
            currentSol = manifest?.sols[solIndex]
        } else {
            solIndex -= 1
            currentSol = manifest?.sols[solIndex]
        }
        
        updateViews()
    }
    
    
    @IBAction func nextTapped(_ sender: Any) {
        guard let count = manifest?.sols.count else {
            solIndex = 0
            currentSol = manifest?.sols[solIndex]
            return
        }
        if (solIndex + 1) < count {
            solIndex += 1
            currentSol = manifest?.sols[solIndex]
        } else {
            solIndex = 0
            currentSol = manifest?.sols[solIndex]
        }
        
        updateViews()
        
    }
    
}

extension SolCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? SolPhotoCollectionViewCell else { return UICollectionViewCell() }
        
        loadImage(for: cell, forItemAt: indexPath)
        
        return cell
    }
    
}

extension SolCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.bounds.width / 2 - 2
        return CGSize(width: width, height: width)
    }
}
