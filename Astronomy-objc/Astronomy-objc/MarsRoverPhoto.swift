//
//  MarsRoverPhoto.swift
//  Astronomy-objc
//
//  Created by Dillon P on 4/26/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

import Foundation

class MarsRoverPhoto: NSObject, Decodable {
    var identifier: Int
    var sol: Int
    var camera: Camera
    var imgSrc: String
    var earthDate: Date
    var rover: Rover
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case sol
        case camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
    
    init(identifier: Int, sol: Int, camera: Camera, imgSrc: String, earthDate: Date, rover: Rover) {
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
        
        let cameraData = try container.decode(Data.self, forKey: .camera)
        camera = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(cameraData) as? Camera ?? Camera()
        
        imgSrc = try container.decode(String.self, forKey: .imgSrc)
        earthDate = try container.decode(Date.self, forKey: .earthDate)
        
        let roverData = try container.decode(Data.self, forKey: .rover)
        rover = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(roverData) as? Rover ?? Rover()
        
        super.init()
    }
    
    required init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // Not sure if this will be necessary yet but saving just in case.
    
    // @objc public class func create(from url: URL) -> MarsRoverPhoto {
    //        let decoder = JSONDecoder()
    //        let marsRoverPhoto = try! decoder.decode(MarsRoverPhoto.self, from: try! Data(contentsOf: url))
    //        return marsRoverPhoto
    //    }
    
}


