//
//  MarsRover.swift
//  Astronomy
//
//  Created by Jessie Ann Griffin on 6/3/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

import Foundation

@objc(CATMarsRover)
class MarsRover: NSObject {
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

    let solDescriptions: [SolDescription]

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

    init(with name: String, launchDate: Date, landingDate: Date) {
        self.name = name
        self.launchDate = launchDate
        self.landingDate = landingDate
    }
}
