//
//  FetchManifestOperation.swift
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/24/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

import Foundation

class FetchManifestOperation: ConcurrentOperation {
    
    let manifestFetcher: ManifestFetcher
    var manifest: MarsMissionManifest?
    
    init(manifestFetcher: ManifestFetcher) {
        self.manifestFetcher = manifestFetcher
    }
    
    override func start() {
        state = .isExecuting
        
        manifestFetcher.fetchManifest(forRover: "curiosity") { manifest, error in
            defer { self.state = .isFinished }
            guard error == nil else { return }
            guard let manifest = manifest else { return }
            self.manifest = manifest
        }
    }
}
