//
//  PhotoManifest.swift
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/19/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

import Foundation

class PhotoManifest {
    
    let name: String
    let maxSol: Int
    let maxDate: Date
    let totalPhotos: Int
    let solPhotos: [SolPhoto]
    
    enum CodingKeys: String, CodingKey {
        case name
        case maxSol
        case maxDate
        case totalPhotos
        case solPhotos = "photos"
    }
    
    init(name: String, maxSol: Int, maxDate: Date, totalPhotos: Int, solPhotos: [SolPhoto]) {
        self.name = name
        self.maxSol = maxSol
        self.maxDate = maxDate
        self.totalPhotos = totalPhotos
        self.solPhotos = solPhotos
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
        result.keyDecodingStrategy = .convertFromSnakeCase
        result.dateDecodingStrategy = .formatted(dateFormatter)
        return result
    }
}
