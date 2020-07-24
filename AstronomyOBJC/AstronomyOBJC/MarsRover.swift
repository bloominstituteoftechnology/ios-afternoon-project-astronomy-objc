//
//  MarsRover.swift
//  AstronomyOBJC
//
//  Created by Kelson Hartle on 7/24/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

import UIKit

class MarsRover: NSObject {

    @objc var name: String
    @objc var totalPhotos: Int
    
    @objc init(name: String, totalPhotos: Int) {
        self.name = name
        self.totalPhotos = totalPhotos
        
    }
}
