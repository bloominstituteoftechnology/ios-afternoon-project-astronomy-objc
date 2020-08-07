//
//  Rover.swift
//  Astronomy
//
//  Created by Claudia Maciel on 8/6/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

import Foundation

@objc class Rover: NSObject {
    @objc var id: Int
    @objc var name: String
    @objc var landingDate: Date
    @objc var launchDate: Date
    @objc var status: String
    @objc var maxSol: Int
    @objc var maxDate: Date
    @objc var totalPhotos: Int

    @objc init(id: Int, name: String, landingDate: Date, launchDate: Date, status: String, maxSol: Int, maxDate: Date, totalPhotos: Int) {
        self.id = id
        self.name = name
        self.landingDate = landingDate
        self.launchDate = launchDate
        self.status = status
        self.maxSol = maxSol
        self.maxDate = maxDate
        self.totalPhotos = totalPhotos
    }
}
