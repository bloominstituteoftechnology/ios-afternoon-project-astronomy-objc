//
//  MarsPhotoReference.swift
//  Astronomy-Hybrid
//
//  Created by Bobby Keffury on 2/12/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import Foundation

@objc(LSIMarsPhotoReference)
class MarsPhotoReference: NSObject {
    
    //MARK: - Properties
    
    let id: Int
    let sol: Int
    /* let camera: Camera */
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
    
    enum CodingKeys: String, CodingKey {
        case id
        case sol
        case camera
        case earthDate
        case imageURL = "imgSrc"
    }
    //MARK: - Initializers
    
    internal init(id: Int, sol: Int, /*camera: Camera,*/ earthDate: Date, imageURL: URL) {
        self.id = id
        self.sol = sol
        /* self.camera = camera */
        self.earthDate = earthDate
        self.imageURL = imageURL
    }
}
