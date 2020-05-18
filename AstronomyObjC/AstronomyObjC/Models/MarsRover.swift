//
//  MarsRover.swift
//  AstronomyObjC
//
//  Created by Christopher Devito on 5/18/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import UIKit

@objcMembers class MarsRover: NSObject {

    let name: String
    let launchDate: Date
    let landingDate: Date
    let status: Status
    let maxSol: Int
    let maxDate: Date
    let numberOfPhotos: Int
    let solDescriptions: [TMCSolDescription]

    init(name: String, launchDate: Date, landingDate: Date, status: MarsRover.Status, maxSol: Int, maxDate: Date, numberOfPhotos: Int, solDescriptions: [TMCSolDescription]) {
        self.name = name
        self.launchDate = launchDate
        self.landingDate = landingDate
        self.status = status
        self.maxSol = maxSol
        self.maxDate = maxDate
        self.numberOfPhotos = numberOfPhotos
        self.solDescriptions = solDescriptions
    }

    enum Status: String, Codable {
        case active, complete
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
