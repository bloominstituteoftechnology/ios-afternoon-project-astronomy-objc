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
    @objc var photos: [SolPhoto]?
    
    @objc init(name: String, max_sol: Int, max_date: Date, total_photos: Int, photos: [SolPhoto]? = []) {
        self.name = name
        self.max_sol = max_sol
        self.max_date = max_date
        self.total_photos = total_photos
        self.photos = photos
    }
    
    @objc convenience init?(dictionary: [String: [String: Any]]) {
        var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }
        
        let dictionaryValues = dictionary["photo_manifest"]
        guard let roverName = dictionaryValues!["name"] as? String,
        let maxSol = dictionaryValues!["max_sol"] as? Int,
        let jsonDate = dictionaryValues!["max_date"] as? String,
        let maxDate = dateFormatter.date(from: jsonDate),
        let totalPhotos = dictionaryValues!["total_photos"] as? Int else { return nil }
        
        self.init(name: roverName, max_sol: maxSol, max_date: maxDate, total_photos: totalPhotos)
    }
    
    @objc static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static var jsonDecoderDateFormatter: JSONDecoder {
        let result = JSONDecoder()
        result.dateDecodingStrategy = .formatted(dateFormatter)
        return result
    }
}
