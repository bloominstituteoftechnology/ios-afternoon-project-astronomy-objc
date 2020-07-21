//
//  Photos.swift
//  AstronomyInteroperability
//
//  Created by Nonye on 7/21/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

import Foundation

@objc class Photos: NSObject, Decodable {
    
    var photos: [MarsRoverPhoto]
    
    init(photos: [MarsRoverPhoto]) {
        self.photos = photos
    }
    
    enum PhotoCodingKeys: String, CodingKey {
        case photos
    }
    
    @objc public class func addMarsPhotos(from nsData: NSData) -> Photos {
        let decoder = JSONDecoder()
        let data = Data(referencing: nsData)
        let allPhotos = try! decoder.decode(Photos.self, from: data)
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
