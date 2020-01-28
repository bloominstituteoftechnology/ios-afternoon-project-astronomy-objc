//
//  SolDescription.swift
//  Astronomy-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class SolDescription: NSObject {
    @objc let sol: Int
    @objc let totalPhotos: Int
    @objc let cameras: [String]

    init(sol: Int, totalPhotos: Int, cameras:[String]) {
        self.sol = sol
        self.totalPhotos = totalPhotos
        self.cameras = cameras
    }

    @objc convenience init?(dictionary: [String : Any]) {
        guard let sol = dictionary["sol"] as? Int,
            let totalPhotos = dictionary["total_photos"] as? Int,
            let cameras = dictionary["cameras"] as? [String] else { return nil }

        self.init(sol: sol, totalPhotos: totalPhotos, cameras: cameras)
    }
}
