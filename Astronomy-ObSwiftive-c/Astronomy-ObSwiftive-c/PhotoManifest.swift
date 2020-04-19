//
//  PhotoManifest.swift
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/19/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

import Foundation

@objc class PhotoManifest: NSObject {
    
    @objc let name: String
    @objc let max_sol: Int
    @objc let max_date: Date
    @objc let total_photos: Int
    @objc let photos: String// [SolPhoto]
    
    @objc init(name: String, max_sol: Int, max_date: Date, total_photos: Int, photos: String) {
        self.name = name
        self.max_sol = max_sol
        self.max_date = max_date
        self.total_photos = total_photos
        self.photos = photos
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static var jsonDecoderSnakeCase: JSONDecoder {
        let result = JSONDecoder()
        result.dateDecodingStrategy = .formatted(dateFormatter)
        return result
    }
}
