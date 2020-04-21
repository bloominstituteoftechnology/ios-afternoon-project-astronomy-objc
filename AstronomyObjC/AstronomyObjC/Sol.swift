//
//  Sol.swift
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/21/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import Foundation

@objc class Sol: NSObject
{
    @objc var photoURL: String
    @objc var sol: Int
    @objc var roverId: Int
    @objc var camera: String
    @objc var takenDate: Date
    
    @objc init(photoURL: String , sol: Int, roverId: Int, camera: String, takenDate: Date) {
        self.photoURL = photoURL
        self.sol = sol
        self.roverId = roverId
        self.camera = camera
        self.takenDate = takenDate
    }
    
}
