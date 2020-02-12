//
//  MarsPhoto.swift
//  Astronomy-Hybrid
//
//  Created by Vici Shaweddy on 2/12/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

import Foundation

@objc
class MarsPhotoReference: NSObject {
    @objc var id: Int
    @objc var sol: Int
//    @objc var camera: Camera
    @objc var earthDate: Date
    @objc var imageURL: URL
    
    @objc init(id: Int, sol: Int, earthDate: Date, imageURL: URL) {
        self.id = id
        self.sol = sol
        self.earthDate = earthDate
        self.imageURL = imageURL
    }
    
    @objc static var dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
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
