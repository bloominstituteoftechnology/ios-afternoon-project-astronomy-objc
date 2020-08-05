//
//  SolDetails.swift
//  AstronomyOBJc
//
//  Created by Kelson Hartle on 7/29/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

import Foundation

class SolDetails: NSObject {
    @objc let sol: Int
    @objc let totalPhotos: Int
    @objc let cameras: [String]

    init(sol: Int, totalPhotos: Int, cameras: [String]) {
        self.sol = sol
        self.totalPhotos = totalPhotos
        self.cameras = cameras
    }

    @objc convenience init?(dictionary: [String : Any]) {
        guard let sol = dictionary["sol"] as? Int,
            let totalPhotos = dictionary["total_photos"] as? Int,
            let cameras = dictionary["cameras"] as? [String] else {
                return nil
        }

        self.init(sol: sol, totalPhotos: totalPhotos, cameras: cameras)
    }
}

