//
//  Photo.swift
//  Astronomy
//
//  Created by Chris Dobek on 6/15/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

import Foundation

@objc class MarsPhoto: NSObject {
    
    @objc let sol: Int
    @objc let cameraName: String
    @objc let cameraFullName: String
    @objc let photoDate: Date
    @objc let imageURL: URL
    @objc let roverID: Int
    @objc let roverName: String
    @objc let photoID: Int
    
    @objc init(sol: Int, cameraName: String, cameraFullName: String, photoDate: Date, imageURL: URL, roverID: Int, roverName: String, photoID: Int) {
        self.sol = sol
        self.cameraName = cameraName
        self.cameraFullName = cameraFullName
        self.photoDate = photoDate
        self.imageURL = imageURL
        self.roverID = roverID
        self.roverName = roverName
        self.photoID = photoID
    }
}
