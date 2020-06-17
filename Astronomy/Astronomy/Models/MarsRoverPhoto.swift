//
//  Photo.swift
//  Astronomy
//
//  Created by Chris Dobek on 6/15/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

import Foundation

@objc class MarsRoverPhoto: NSObject, Decodable {
    
    var identifier: Int
    var sol: Int
    var camera: CMDCamera
    var imgScr: String
    var earthDate: String
    var rover: CMDRover
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case sol
        case camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
    
    enum CameraCodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case roverID = "rover_id"
        case fullName = "full_name"
    }
    
    enum RoverCodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalPhotos = "total_photos"
    }
    
    init(identifier: Int, sol: Int, camera: CMDCamera, imgSrc: String, earthDate: String, rover: CMDRover) {
        self.identifier = identifier
        self.sol = sol
        self.camera = camera
        self.imgScr = imgSrc
        self.earthDate = earthDate
        self.rover = rover
    }
    
    public required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        identifier = try container.decode(Int.self, forKey: .identifier)
        sol = try container.decode(Int.self, forKey: .sol)
        
        let cameraContainer = try container.nestedContainer(keyedBy: CameraCodingKeys.self, forKey: .camera)
        let cameraID = try cameraContainer.decode(Int32.self, forKey: .identifier)
        let cameraName = try cameraContainer.decode(String.self, forKey: .name)
        let roverID = try cameraContainer.decode(Int32.self, forKey: .roverID)
        let fullName = try cameraContainer.decode(String.self, forKey: .fullName)
        let camera = CMDCamera(identifier: cameraID, name: cameraName, roverID: roverID, fullName: fullName)
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
        let totalPhotos = try roverContainer.decode(Int32.self, forKey: .totalPhotos)
        let rover = CMDRover(identifier: roverID, name: roverName, landingDate: landingDate, launchDate: launchDate, status: status, maxSol: maxSol, maxDate: maxDate, totalPhotos: totalPhotos, sols: nil)
        self.rover = rover
        
        
        super.init()
    }
    
}
