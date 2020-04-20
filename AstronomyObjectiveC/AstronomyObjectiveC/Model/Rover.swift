//
//  Rover.swift
//  AstronomyObjectiveC
//
//  Created by Enrique Gongora on 4/20/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
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
