//
//  MarsPhoto.swift
//  Astronomy
//
//  Created by Cody Morley on 7/20/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

import Foundation

@objc (CAMMarsPhoto)
struct MarsPhotoReference {
    //MARK: - Types -
    enum CodingKeys: String, CodingKey {
        case id
        case sol
        case camera
        case earthDate
        case imageURL = "imgSrc"
    }
    
    //MARK: - Properties -
    let id: Int
    let sol: Int
    let camera: Camera
    let earthDate: Date
    let imageURL: URL
    
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
    
    
    //MARK: - Initializers -
    init(with dictionary: [String : Any]) {
        let id: Int = dictionary["id"] as! Int
        let sol: Int = dictionary["sol"] as! Int
        let camera: Camera = dictionary["camera"] as! Camera
        let earthDate: Date = dictionary["earth_date"] as! Date
        let imageURL: URL = dictionary["imgSrc"] as! URL
        
        self.id = id
        self.sol = sol
        self.camera = camera
        self.earthDate = earthDate
        self.imageURL = imageURL
    }
}
