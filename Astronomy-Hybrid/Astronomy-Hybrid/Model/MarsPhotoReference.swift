//
//  MarsPhotoReference.swift
//  Astronomy-Hybrid
//
//  Created by Isaac Lyons on 12/16/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

import Foundation

@objc class MarsPhotoReference: NSObject {
    @objc let id: Int
    @objc let sol: Int
    @objc let imageURL: URL
    
    @objc init(id: Int, sol: Int, imageURL: URL) {
        self.id = id
        self.sol = sol
        self.imageURL = imageURL
    }
    
    @objc init?(with dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? Int,
            let sol = dictionary["sol"] as? Int,
            let imageString = dictionary["img_src"] as? String,
            let imageURL = URL(string: imageString) else {
            return nil
        }
        
        self.id = id
        self.sol = sol
        self.imageURL = imageURL
        super.init()
    }
    
    
    override var description: String {
        return "Photo id: \(id) - sol: \(sol) - URL: \(imageURL.absoluteString)"
    }
}
