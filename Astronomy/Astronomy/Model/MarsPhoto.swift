//
//  MarsRover.swift
//  Astronomy
//
//  Created by Jesse Ruiz on 12/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

@objc class MarsPhotoReference: NSObject {
    
    @objc let id: Int
    @objc let sol: Int
    @objc let camera: Camera
    @objc let earthDate: Date
    @objc let imageURL: URL
    @objc var dictionary: [String: Any]?
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "imgsrc"
    }
    
    
    @objc init(id: Int, sol: Int, camera: Camera, earthDate: Date, imageURL: URL) {
        self.id = id
        self.sol = sol
        self.camera = camera
        self.earthDate = earthDate
        self.imageURL = imageURL
    }
    
    @objc convenience init(dictionary: [String: Any]) {
        let solNumber = dictionary["sol"] as? Int
        self.init(id: 0, sol: solNumber!, camera: Camera(), earthDate: Date(), imageURL: URL(string: "http://apple.com")!)
    }
}
