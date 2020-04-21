//
//  Sol.swift
//  AstronomyObjC
//
//  Created by Chris Gonzales on 4/21/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import Foundation

class Sol: NSObject {
    
    // MARK: - Properties
    @objc let sol: Int
    @objc let totalPhotos: Int
    @objc let cameras: [String]
    
    // MARK: - Initializers
    
    init(sol: Int,
         totalPhotos: Int,
         cameras: [String]) {
        self.sol = sol
        self.totalPhotos = totalPhotos
        self.cameras = cameras
    }
    
    @objc convenience init?(dictionary: [String: Any]) {
        guard let sol = dictionary["sol"] as? Int,
            let totalPhotos = dictionary["total_photos"] as? Int,
            let cameras = dictionary["cameras"] as? String .ExtendedGraphemeClusterLiteralType else {
                return nil
        }
        self.init(sol: sol,
                  totalPhotos: totalPhotos,
                  cameras: cameras)
    }
}
