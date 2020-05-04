//
//  SolDescription.swift
//  Astronomy
//
//  Created by Andrew R Madsen on 9/5/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class SolDescription: NSObject {

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

    @objc let sol: Int
    @objc let totalPhotos: Int
    @objc let cameras: [String]
}
