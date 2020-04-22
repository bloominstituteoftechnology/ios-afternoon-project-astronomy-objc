//
//  MainCollectionViewController.swift
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/22/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

class MainCollectionViewController : UICollectionViewController {
    
    let manifestFetcher = ManifestFetcher()
    let photoFetcher = SolFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manifestFetcher.fetchManifest(forRover: "curiosity") { (manifest, _) in
            print(manifest)
        }
        
        photoFetcher.fetchPhotos(forRover: "curiosity", withSol:2) { (sol, _) in
            print(sol?.first?.imageURL)
        }
        
    }

}
