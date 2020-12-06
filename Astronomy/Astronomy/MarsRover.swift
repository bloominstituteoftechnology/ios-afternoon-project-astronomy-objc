//
//  MarsRover.swift
//  Astronomy
//
//  Created by Cora Jacobson on 12/5/20.
//

import Foundation

@objcMembers
class MarsRover: NSObject {
    
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
    
    var name: String
    var launchDate: Date
    var landingDate: Date
    var status: String
    var maxSol: Int
    var maxDate: Date
    var numberOfPhotos: Int
    var solDescriptions: [SolDescription]
    
    @objc init(name: String, launchDate: Date, landingDate: Date, status: String, maxSol: Int, maxDate: Date, numberOfPhotos: Int, solDescriptions: [SolDescription]) {
        self.name = name
        self.launchDate = launchDate
        self.landingDate = landingDate
        self.status = status
        self.maxSol = maxSol
        self.maxDate = maxDate
        self.numberOfPhotos = numberOfPhotos
        self.solDescriptions = solDescriptions
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
