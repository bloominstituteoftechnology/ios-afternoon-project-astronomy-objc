//
//  MarsRover.swift
//  AstronomyOBJc
//
//  Created by Kelson Hartle on 7/25/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

import Foundation

class MarsRover: NSObject {

    @objc var name: String
    @objc var totalPhotos: Int
    
    @objc init(name: String, totalPhotos: Int) {
        self.name = name
        self.totalPhotos = totalPhotos
        
    }
    
    @objc(initWithDictionary:)
    init?(dictionary: [String:Any]) {
        guard let photoManifestDictionary = dictionary["photo_manifest"] as? NSDictionary else {return nil}
        
        guard let name = photoManifestDictionary["name"] as? String else { return nil }
        guard let totalPhotos = photoManifestDictionary["total_photos"] as? Int else { return nil }
        
        
        self.name = name
        self.totalPhotos = totalPhotos
    }
}

