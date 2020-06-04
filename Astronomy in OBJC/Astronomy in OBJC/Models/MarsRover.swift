//
//  MarsRover.swift
//  Astronomy in OBJC
//
//  Created by Sal B Amer on 6/4/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

//@objcMembers class Rover: NSObject {
//  var name: String
//  var photos: String?
//
//  init(name: String, photos: String?) {
//    self.name = name
//    self.photos = photos
//  }
//}
import UIKit

@objcMembers class MarsRover: NSObject {

    let name: String
    let launchDate: Date
    let landingDate: Date
    let status: Status
    let maxSol: Int
    let maxDate: Date
    let numberOfPhotos: Int
    let solDescriptions: [SolDescription]

    init(name: String, launchDate: Date, landingDate: Date, status: MarsRover.Status, maxSol: Int, maxDate: Date, numberOfPhotos: Int, solDescriptions: [SolDescription]) {
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
