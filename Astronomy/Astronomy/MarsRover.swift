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
    
    @objc init(name: String, launchDate: String, landingDate: String, status: String, maxSol: String, maxDate: String, numberOfPhotos: String, solDescriptions: [SolDescription]) {
        let formatter = dateFormatter
        self.name = name
        self.launchDate = formatter.date(from: launchDate) ?? Date()
        self.landingDate = formatter.date(from: landingDate) ?? Date()
        self.status = status
        self.maxSol = Int(maxSol) ?? 0
        self.maxDate = formatter.date(from: maxDate) ?? Date()
        self.numberOfPhotos = Int(numberOfPhotos) ?? 0
        self.solDescriptions = solDescriptions
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
}
