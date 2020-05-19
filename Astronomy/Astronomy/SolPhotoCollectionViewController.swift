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
    
    // Networking Client
    let nasaMarsClient = NasaMarsClient()
    
    var sols: [MarsSol] = []
    var sol: MarsSol? { didSet { updateUI() }}
    var photos: [MarsPhoto] = []
    
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
            
            self.sols = manifest.sols.filter { $0.numPhotos > 0 }
            DispatchQueue.main.async {
                self.sol = self.sols[20]
            }
        }
    }
    
    private func updateUI() {
        guard let sol = sol else { return }
        title = "Sol \(sol.solNumber)"
        fetchPhotos(for: sol)
    }
    
    private func fetchPhotos(for sol: MarsSol) {
        nasaMarsClient.fetchPhotos(forRoverNamed: roverName, on: sol) { (photos, error) in
            if let error = error {
                print(error)
            }
            
            guard let photos = photos else { return }
            
            DispatchQueue.main.async {
                self.photos = photos
                self.collectionView.reloadData()
            }
        }
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
