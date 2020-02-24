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

    override func viewDidLoad() {
        super.viewDidLoad()
        manifestFetcher.fetchManifest(forRover: "curiosity") { manifest, error in
            guard error == nil else { return }
            
            guard let manifest = manifest else { return }
            print(manifest.sols)
        }
    }
}
