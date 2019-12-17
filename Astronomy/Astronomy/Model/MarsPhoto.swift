//
//  MarsRover.swift
//  Astronomy
//
//  Created by Jesse Ruiz on 12/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

@objc class MarsPhotoReference: NSObject {
    
    @objc let id: Int
    @objc let sol: Int
    @objc let camera: Camera
    @objc let earthDate: Date
    @objc let imageURL: URL
    @objc var dictionary: [String: String]?
    
    
    @objc init(id: Int, sol: Int, camera: Camera, earthDate: Date, imageURL: URL) {
        self.id = id
        self.sol = sol
        self.camera = camera
        self.earthDate = earthDate
        self.imageURL = imageURL
    }
    
    @objc convenience init(dictionary: [String: String]) {
        self.init(dictionary: dictionary)
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static var jsonDecoder: JSONDecoder {
        let result = JSONDecoder()
        result.keyDecodingStrategy = .convertFromSnakeCase
        result.dateDecodingStrategy = .formatted(dateFormatter)
        return result
    }
}
