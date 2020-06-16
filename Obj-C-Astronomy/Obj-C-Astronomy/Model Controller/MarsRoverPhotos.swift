//
//  MarsRoverPhotos.swift
//  Obj-C-Astronomy
//
//  Created by Patrick Millet on 6/16/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

import Foundation

@objc class MarsRoverPhotos: NSObject, Decodable {
    var photos: [MarsRoverPhoto]

    init(photos: [MarsRoverPhoto]) {
        self.photos = photos
    }
    
    enum PhotoCodingKeys: String, CodingKey {
        case photos
    }
    
    @objc public class func createMarsRoverPhotos(from nsData: NSData) -> MarsRoverPhotos {
        let decoder = JSONDecoder()
        let data = Data(referencing: nsData)
        let allPhotos = try! decoder.decode(MarsRoverPhotos.self, from: data)
        return allPhotos
    }
    
    public required init(from decoder: Decoder) throws {
        let topContainer = try decoder.container(keyedBy: PhotoCodingKeys.self)
        var photoContainer = try topContainer.nestedUnkeyedContainer(forKey: .photos)
        self.photos = []
        
        while !photoContainer.isAtEnd {
            let photo = try photoContainer.decode(MarsRoverPhoto.self)
            self.photos.append(photo)
        }
        super.init()
    }
}

class MarsRoverPhoto: NSObject, Decodable {
    var identifier: Int
    var sol: Int
    var camera: Camera
    var imgSrc: String
    var earthDate: String
    var rover: Rover
    
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
    
    init(identifier: Int, sol: Int, camera: Camera, imgSrc: String, earthDate: String, rover: Rover) {
        self.identifier = identifier
        self.sol = sol
        self.camera = camera
        self.imgSrc = imgSrc
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
        let camera = Camera(identifier: cameraID, name: cameraName, roverID: roverID, fullName: fullName)
        self.camera = camera
        
        imgSrc = try container.decode(String.self, forKey: .imgSrc)
        earthDate = try container.decode(String.self, forKey: .earthDate)
        
        let roverContainer = try container.nestedContainer(keyedBy: RoverCodingKeys.self, forKey: .rover)
        let roverName = try roverContainer.decode(String.self, forKey: .name)
        let landingDate = try roverContainer.decode(String.self, forKey: .landingDate)
        let launchDate = try roverContainer.decode(String.self, forKey: .launchDate)
        let status = try roverContainer.decode(String.self, forKey: .status)
        let maxSol = try roverContainer.decode(Int32.self, forKey: .maxSol)
        let maxDate = try roverContainer.decode(String.self, forKey: .maxDate)
        let totalPhotos = try roverContainer.decode(Int32.self, forKey: .totalPhotos)
        let rover = Rover(identifier: roverID, name: roverName, landingDate: landingDate, launchDate: launchDate, status: status, maxSol: maxSol, maxDate: maxDate, totalPhotos: totalPhotos, sols: nil)
        self.rover = rover
        
        
        super.init()
    }
}
