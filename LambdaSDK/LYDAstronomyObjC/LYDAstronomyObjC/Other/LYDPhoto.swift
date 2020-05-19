//
//  LYDPhoto.swift
//  LYDAstronomyObjC
//
//  Created by Lydia Zhang on 5/18/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

import Foundation

 class LYDPhoto: NSObject {
    var identifier: Int?
    var sol: Int?
    var camera: String?
    var earthDate: Date?
    var imageURL: URL?
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    @objc init(photoDictionary: Dictionary<String, Any>) {

        if let identifier = photoDictionary["id"] as? Int {
            self.identifier = identifier
        }
        if let sol = photoDictionary["sol"] as? Int {
            self.sol = sol
        }
        if let dateStr = photoDictionary["earth_date"] as? String,
            let date = dateFormatter.date(from: dateStr) {
            self.earthDate = date
        }
        if let urlStr = photoDictionary["img_src"] as? String,
            let url = URL(string: urlStr) {
            self.imageURL = url
        }
    }
}
