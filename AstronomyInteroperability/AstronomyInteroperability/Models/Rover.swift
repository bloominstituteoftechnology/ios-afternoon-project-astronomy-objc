//
//  Rover.swift
//  AstronomyInteroperability
//
//  Created by Nonye on 7/20/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
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
