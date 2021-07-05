//
//  MarsRover.swift
//  Astronomy-Hybrid
//
//  Created by Jerry haaser on 1/27/20.
//  Copyright © 2020 Jerry haaser. All rights reserved.
//

import Foundation

class MarsRover {
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
    
    //let solDescriptions: [SolDescription]
    
    enum CodingKeys: String, CodingKey {
        case name
        case launchDate
        case landingDate
        case status
        case maxSol
        case maxDate
        case numberOfPhotos = "totalPhotos"
        case solDescriptions = "photos"
    }
    
    init(name: String, launchDate: Date, landingDate: Date, status: Status, maxSol: Int, maxDate: Date, numberOfPhotos: Int) {
        self.name = name
        self.launchDate = launchDate
        self.landingDate = landingDate
        self.status = status
        self.maxSol = maxSol
        self.maxDate = maxDate
        self.numberOfPhotos = numberOfPhotos
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

