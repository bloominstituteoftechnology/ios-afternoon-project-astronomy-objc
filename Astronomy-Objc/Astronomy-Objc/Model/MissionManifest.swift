//
//  MissionManifest.swift
//  Astronomy-Objc
//
//  Created by Michael on 3/23/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation

// MARK: - API Key XmXYMWlVPWhzbE7kCMN08ho7VdpaeEDPpfC5TG2b

@objc class MissionManifest: NSObject {
    @objc var name: String
    @objc var landingDate: Date
    @objc var launchDate: Date
    @objc var status: String
    @objc var maxSol: Int
    @objc var maxDate: Date
    @objc var totalPhotos: Int
    @objc var solInfo: [MBMSolInfo]

    
    @objc init(name: String, landingDate: Date, launchDate: Date, status: String, maxSol: Int, maxDate: Date, totalPhotos: Int, solInfo: [MBMSolInfo]) {
        self.name = name
        self.landingDate = landingDate
        self.launchDate = launchDate
        self.status = status
        self.maxSol = maxSol
        self.maxDate = maxDate
        self.totalPhotos = totalPhotos
        self.solInfo = solInfo
    }
    
    @objc convenience init?(dictionary: NSDictionary) {
        
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(abbreviation: "GMT")
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
        
        guard
            let name = dictionary["name"] as? String,
            let landingDate = dictionary["landing_date"] as? String,
            let launchDate = dictionary["launch_date"]as? String,
            let status = dictionary["status"] as? String,
            let maxSol = dictionary["max_sol"] as? Int,
            let maxDate = dictionary["max_date"] as? String,
            let totalPhotos = dictionary["total_photos"] as? Int,
            let solInfo = dictionary["photos"] as? MBMSolInfo
            else { return nil }
        
        self.init(name: name,
                  landingDate: dateFormatter.date(from: landingDate) ?? Date(),
                  launchDate: dateFormatter.date(from: launchDate) ?? Date(),
                  status: status,
                  maxSol: maxSol,
                  maxDate: dateFormatter.date(from: maxDate) ?? Date(),
                  totalPhotos: totalPhotos,
                  solInfo: [solInfo])
    }
}
