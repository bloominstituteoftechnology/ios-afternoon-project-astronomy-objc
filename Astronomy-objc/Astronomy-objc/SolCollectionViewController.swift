//
//  SolCollectionViewController.swift
//  Astronomy-objc
//
//  Created by Dillon P on 4/26/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

import UIKit

private let reuseIdentifier = "RoverPhotoCell"

class SolCollectionViewController: UICollectionViewController {
    
    let marsRoverController = MarsRoverController()
    var rover: Rover?
    var sols: [Int32]?
    var photoUrls = [String]()
    var imageCache = [String : UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMissionManifest()
        
        self.clearsSelectionOnViewWillAppear = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Initial App Load Networking Methods
    
    private func fetchMissionManifest() {
        marsRoverController.fetchMissionManifest { (rover, error) in
            if let error = error {
                print("Error fetching mission manifest: \(error)")
            }

            if let rover = rover {
                self.rover = rover
                
                guard let sols = rover.sols as? [Int32] else {
                    print("Sols could not be loaded")
                    return
                }
                let sol = sols[1]
            
                self.loadPhotosForSol(sol: sol)
                return
            }
        }
    }
    
    private func loadPhotosForSol(sol: Int32) {
        marsRoverController.fetchAllPhotos(forSol: sol) { (allPhotos, error) in
            if let error = error {
                print("Error fetching photos for sol: \(error)")
                return
            }
            
            guard let allPhotos = allPhotos else {
                print("Error loading all photo references")
                return
            }
            
            for photo in allPhotos.photos {
                let imgSrc = photo.imgSrc
                self.photoUrls.append(imgSrc)
            }
            
            self.fetchImageForURLString(urlStrings: self.photoUrls) { (_, error) in
                if let error = error {
                    print("Error fetching image: \(error)")
                }
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    
    
    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoUrls.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? RoverPhotoCollectionViewCell else { return UICollectionViewCell() }
        
        let imgSrcURLString = photoUrls[indexPath.item]
        if let image = imageCache[imgSrcURLString] {
            cell.roverImage?.image = image
        }
        
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
    
    // MARK: - Rover Image Fetching Methods and Operations
    
    func fetchImageForURLString(urlStrings: [String], completion: @escaping (UIImage?, Error?) -> Void) {
        for urlString in urlStrings {
            let httpUrl = URL(string: urlString)
            
            guard let httpsURLString = getSecureURL(url: httpUrl) else {
                return
            }
            
            marsRoverController.fetchSingleImage(httpsURLString) { (image, error) in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                if let image = image {
                    self.imageCache[urlString] = image
                    completion(image, nil)
                    return
                }
            }
        }
    }
    
    private func getSecureURL(url: URL?) -> String? {
        guard let url = url, var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        components.scheme = "https"
        return components.url?.absoluteString
    }

}
