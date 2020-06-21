//
//  MarsPhotoReference.swift
//  Astronomy-ObjC
//
//  Created by John Kouris on 2/12/20.
//  Copyright © 2020 John Kouris. All rights reserved.
//

import Foundation

@objc class MarsPhotoReference: NSObject {
    @objc let id: Int
    @objc let sol: Int
    @objc let imageURL: URL
    @objc let dateString: String
    
    @objc init(id: Int, sol: Int, imageURL: URL, dateString: String) {
        self.id = id
        self.sol = sol
        self.imageURL = imageURL
        self.dateString = dateString
    }
    
    @objc init?(with dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? Int,
            let sol = dictionary["sol"] as? Int,
            let imageString = dictionary["img_src"] as? String,
            let imageURL = URL(string: imageString),
            let dateString = dictionary["earth_date"] as? String else {
            return nil
        }
        
        self.id = id
        self.sol = sol
        self.imageURL = imageURL
        self.dateString = dateString
        super.init()
    }
}
