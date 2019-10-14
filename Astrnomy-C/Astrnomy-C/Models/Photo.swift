//
//  Photo.swift
//  Astrnomy-C
//
//  Created by Jeffrey Santana on 10/14/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

class Photo: NSObject {
    var id: Int?
    var sol: Int?
//    let camera: Camera?
    var earthDate: Date?
    
    var imageURL: URL?
	
//	init(id: Int, sol: Int, earthDate: Date, imageURLString: String) {
//		self.id = id
//		self.sol = sol
//		self.earthDate = earthDate
//		self.imageURL = URL(string: imageURLString)
//	}

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
//    static var jsonDecoder: JSONDecoder {
//        let result = JSONDecoder()
//        result.keyDecodingStrategy = .convertFromSnakeCase
//        result.dateDecodingStrategy = .formatted(dateFormatter)
//        return result
//    }
	
	
	@objc init(dictionary: Dictionary<String, Any>) {
		
		if let id = dictionary["id"] as? Int {
			self.id = id
		}
		if let sol = dictionary["isold"] as? Int {
			self.sol = sol
		}
		if let dateString = dictionary["earthDate"] as? String, let date = dateFormatter.date(from: dateString) {
			self.earthDate = date
		}
		if let urlString = dictionary["imageSrc"] as? String, let url = URL(string: urlString) {
			self.imageURL = url
		}
	}
}
