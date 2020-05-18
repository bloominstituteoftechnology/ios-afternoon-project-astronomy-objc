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
    
    @objc init(dictionary: Dictionary<String, Any>) {

        if let identifier = dictionary["id"] as? Int {
            self.identifier = identifier
        }
        if let sol = dictionary["isold"] as? Int {
            self.sol = sol
        }
        if let dateStr = dictionary["earthDate"] as? String,
            let date = dateFormatter.date(from: dateStr) {
            self.earthDate = date
        }
        if let urlStr = dictionary["imageSrc"] as? String,
            let url = URL(string: urlStr) {
            self.imageURL = url
        }
    }
}
