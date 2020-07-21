//
//  MarsRoverPhoto.swift
//  AstronomyInteroperability
//
//  Created by Nonye on 7/21/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

import Foundation

@objc class MarsRoverPhoto: NSObject, Decodable {
    
    var cameraID: Int
    var sol: Int
    var camera: Camera
    var imgScr: String
    var earthDate: String
    var rover: MarsRover
    
    enum CodingKeys: String, CodingKey {
        case cameraID = "id"
        case sol
        case camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
    
    enum CameraCodingKeys: String, CodingKey {
        case cameraID = "id"
        case name
        case roverID = "rover_id"
        case fullName = "full_name"
    }
    
    enum RoverCodingKeys: String, CodingKey {
        case cameraID = "id"
        case name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case numberOfPhotos = "total_photos"
    }
    
    init(cameraID: Int, sol: Int, camera: Camera, imgSrc: String, earthDate: String, rover: MarsRover) {
        self.cameraID = cameraID
        self.sol = sol
        self.camera = camera
        self.imgScr = imgSrc
        self.earthDate = earthDate
        self.rover = rover
    }
    
    public required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        cameraID = try container.decode(Int.self, forKey: .cameraID)
        sol = try container.decode(Int.self, forKey: .sol)
        
        let cameraContainer = try container.nestedContainer(keyedBy: CameraCodingKeys.self, forKey: .camera)
        let cameraID = try cameraContainer.decode(Int32.self, forKey: .cameraID)
        let cameraName = try cameraContainer.decode(String.self, forKey: .name)
        let roverID = try cameraContainer.decode(Int32.self, forKey: .roverID)
        let fullName = try cameraContainer.decode(String.self, forKey: .fullName)
        let camera = Camera(id: cameraID, roverID: roverID, name: cameraName, fullName: fullName)
        self.camera = camera
        
        imgScr = try container.decode(String.self, forKey: .imgSrc)
        earthDate = try container.decode(String.self, forKey: .earthDate)
        
        let roverContainer = try container.nestedContainer(keyedBy: RoverCodingKeys.self, forKey: .rover)
        let roverName = try roverContainer.decode(String.self, forKey: .name)
        let landingDate = try roverContainer.decode(String.self, forKey: .landingDate)
        let launchDate = try roverContainer.decode(String.self, forKey: .launchDate)
        let status = try roverContainer.decode(String.self, forKey: .status)
        let maxSol = try roverContainer.decode(Int32.self, forKey: .maxSol)
        let maxDate = try roverContainer.decode(String.self, forKey: .maxDate)
        let totalPhotos = try roverContainer.decode(Int32.self, forKey: .numberOfPhotos)
        let rover = MarsRover(id: roverID, name: roverName, launchDate: launchDate, landingDate: landingDate,status: status, maxSol: maxSol, maxDate: maxDate, numberOfPhotos: totalPhotos, sols: nil)
        self.rover = rover
        
        
        super.init()
    }
    
}
