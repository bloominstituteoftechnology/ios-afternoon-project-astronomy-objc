//
//  Rover.swift
//  AstronomyMix
//
//  Created by Jorge Alvarez on 3/23/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

@objc class Rover: NSObject {
    
    @objc var name: String
    @objc var photos: String?
    
    @objc init(name: String, photos: String?) {
        self.name = name
        self.photos = photos
    }
}
