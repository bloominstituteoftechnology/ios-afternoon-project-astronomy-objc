//
//  ViewController.swift
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/24/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let manifestFetcher = CARManifestFetcher()
    var manifest: CARMarsMissionManifest?
    let solFetcher = CARSolFetcher()

    override func viewDidLoad() {
        super.viewDidLoad()
        manifestFetcher.fetchManifest(forRover: "curiosity") { manifest, error in
            guard error == nil else { return }
            
            guard let manifest = manifest else { return }
            self.manifest = manifest
        }
        
        solFetcher.fetchPhotos(forRover: "curiosity", withSol: 1000) { sols, error in
            guard error == nil else { return }
            guard let sols = sols else { return }
            print(sols)
        }
    }
}
