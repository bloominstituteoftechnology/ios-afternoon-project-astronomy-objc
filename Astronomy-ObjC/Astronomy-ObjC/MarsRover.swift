//
//  MarsRover.swift
//  Astronomy-ObjC
//
//  Created by John Kouris on 2/12/20.
//  Copyright © 2020 John Kouris. All rights reserved.
//

import Foundation

class MarsRover: Codable {
    
    let name: String
    
    let launchDate: Date
    let landingDate: Date
    
    enum Status: String, Codable {
        case active, complete
    }
    let status: Status
    
    let maxSol: Int
    let maxDate: Date
    
    let numberOfPhotos: Int
    
//    let solDescriptions: [SolDescription]
    
    internal init(name: String, launchDate: Date, landingDate: Date, status: MarsRover.Status, maxSol: Int, maxDate: Date, numberOfPhotos: Int) {
        self.name = name
        self.launchDate = launchDate
        self.landingDate = landingDate
        self.status = status
        self.maxSol = maxSol
        self.maxDate = maxDate
        self.numberOfPhotos = numberOfPhotos
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case launchDate
        case landingDate
        case status
        case maxSol
        case maxDate
        case numberOfPhotos = "totalPhotos"
//        case solDescriptions = "photos"
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
