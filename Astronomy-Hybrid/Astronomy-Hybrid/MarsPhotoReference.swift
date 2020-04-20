//
//  MarsPhoto.swift
//  Astronomy-Hybrid
//
//  Created by Vici Shaweddy on 2/12/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

import Foundation

@objc
class MarsPhotoReference: NSObject {
    @objc let id: Int
    @objc let sol: Int
    @objc let camera: Camera
    @objc let earthDate: Date
    @objc let imageURL: URL
    
    @objc init(withDictionary dictionary: NSDictionary) {
        self.id = dictionary.object(forKey: "id") as! Int
        self.sol = dictionary.object(forKey: "sol") as! Int
        let cameraDict = dictionary.object(forKey: "camera") as! [AnyHashable : Any]
        self.camera = Camera(dictionary: cameraDict)
        let dateString = dictionary.object(forKey: "earth_date") as! String
        self.earthDate = MarsPhotoReference.dateFormatter.date(from: dateString) ?? Date()
        let urlString = dictionary.object(forKey: "img_src") as! String
        self.imageURL = URL(string: urlString)!
    }
    
    @objc init(id: Int, sol: Int, camera: Camera, earthDate: Date, imageURL: URL) {
        self.id = id
        self.sol = sol
        self.camera = camera
        self.earthDate = earthDate
        self.imageURL = imageURL
    }
    
    @objc static let dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
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
