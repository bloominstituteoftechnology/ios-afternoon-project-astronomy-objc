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
    @objc var solDetails: [LSISolDetails]
    
    @objc init(name: String, totalPhotos: Int, solDetails: [LSISolDetails]) {
        self.name = name
        self.totalPhotos = totalPhotos
        self.solDetails = solDetails
    }
    
    var testArray: [LSISolDetails] = []
    
    @objc(initWithDictionary:)
    init?(dictionary: [String:Any]) {
        guard let photoManifestDictionary = dictionary["photo_manifest"] as? NSDictionary else {return nil}
        
        guard let name = photoManifestDictionary["name"] as? String else { return nil }
        guard let totalPhotos = photoManifestDictionary["total_photos"] as? Int else { return nil }
        guard let solDetailDict = photoManifestDictionary["photos"] as? [[String:Any]] else { return nil}
        
        for sol in solDetailDict {
            let newSolDetail = LSISolDetails(dictionary: sol)
            testArray.append(newSolDetail)
        }
        
        
        self.name = name
        self.totalPhotos = totalPhotos
        self.solDetails = testArray
    }
}

