//
//  Photo.swift
//  Astrnomy-C
//
//  Created by Jeffrey Santana on 10/14/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

struct Photo: NSObject {
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
    
//    static var jsonDecoder: JSONDecoder {
//        let result = JSONDecoder()
//        result.keyDecodingStrategy = .convertFromSnakeCase
//        result.dateDecodingStrategy = .formatted(dateFormatter)
//        return result
//    }
	
	@objc init(dictionary: Dictionary) {
		#warning("Break down photo dictionary")
	}
}
