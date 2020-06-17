//
//  MarsRoverPhotos.swift
//  Astronomy
//
//  Created by Chris Dobek on 6/17/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
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
