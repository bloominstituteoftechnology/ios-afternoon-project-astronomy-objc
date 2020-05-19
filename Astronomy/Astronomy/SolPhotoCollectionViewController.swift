//
//  SolPhotoCollectionViewController.swift
//  Astronomy
//
//  Created by Shawn Gee on 5/18/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

let roverName = "curiosity"

class SolPhotoCollectionViewController: UICollectionViewController {

    // MARK: - Private Properties
  
    let nasaMarsClient = NasaMarsClient()
    
    var sols: [MarsSol] = []
    var solIndex = 0 { didSet { updateUI() }}
    var photos: [MarsPhoto] = []
    
    // MARK: - IBOutlets
    
    @IBOutlet var previousSolButton: UIBarButtonItem!
    @IBOutlet var nextSolButton: UIBarButtonItem!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSols()
    }
    
    // MARK: - Private Methods
    
    private func fetchSols() {
        nasaMarsClient.fetchManifest(forRoverNamed: roverName) { (manifest, error) in
            if let error = error {
                print(error)
            }
            
            guard let manifest = manifest else { return }
            
            self.sols = manifest.sols.filter { 0 < $0.numPhotos && $0.numPhotos < 100 }
            DispatchQueue.main.async {
                self.solIndex = 0
            }
        }
    }
    
    private func updateUI() {
        let sol = sols[solIndex]
        
        previousSolButton.isEnabled = solIndex != 0
        nextSolButton.isEnabled = solIndex != sols.count - 1
        title = "Sol \(sol.solNumber)"
        
        fetchPhotos(for: sol) {
            self.collectionView.setContentOffset(.zero, animated: false)
            self.collectionView.reloadData()
        }
    }
    
    private func fetchPhotos(for sol: MarsSol, completion: @escaping (() -> Void)) {
        nasaMarsClient.fetchPhotos(forRoverNamed: roverName, on: sol) { (photos, error) in
            if let error = error {
                print(error)
            }
            
            guard let photos = photos else { return }
            
            DispatchQueue.main.async {
                self.photos = photos
                completion()
            }
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func previousSol(_ sender: Any) {
        solIndex -= 1
    }
    
    @IBAction func nextSol(_ sender: Any) {
        solIndex += 1
    }
    

    // MARK: Collection View Data Source

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("Unable to cast cell as \(PhotoCollectionViewCell.self)")
        }
        
        cell.photo = photos[indexPath.row]
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photoDetailVC = segue.destination as? PhotoDetailViewController,
            let indexPath = collectionView.indexPathsForSelectedItems?.first {
            photoDetailVC.photo = photos[indexPath.item]
        }
    }
    
}

// MARK: - Flow Layout Delegate

extension SolPhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        return CGSize(width: width, height: width)
    }
}
