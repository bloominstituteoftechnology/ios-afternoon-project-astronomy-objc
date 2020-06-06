//
//  Photo.swift
//  Astronomy-Interoperability
//
//  Created by Christian Lorenzo on 6/3/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

import Foundation


@objc class Photo: NSObject {
    @objc let sol: Int
    @objc let cameraName: String
    @objc let cameraFullName: String
    @objc let photoDate: Date
    @objc let imgSrc: URL
    @objc let roverID: Int
    @objc let roverName: String
    @objc let photoID: Int
    
    @objc init(sol: Int, cameraName: String, cameraFullName: String, photoDate: Date, imgSrc: URL, roverID: Int, roverName: String, photoID: Int) {
        self.sol = sol
        self.cameraName = cameraName
        self.cameraFullName = cameraFullName
        self.photoDate = photoDate
        self.imgSrc = imgSrc
        self.roverID = roverID
        self.roverName = roverName
        self.photoID = photoID
    }
}
