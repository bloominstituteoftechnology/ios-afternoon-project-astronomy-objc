//
//  Rover.swift
//  Astronomy-objc
//
//  Created by Matthew Martindale on 8/5/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

import Foundation

@objc
class Rover: NSObject {
    @objc var name: String
    @objc var status: String
    
    init(name: String, status: String) {
        self.name = name
        self.status = status
    }
    
    @objc convenience init?(dictionary: [String : Any]) {
        guard let name = dictionary["name"] as? String,
            let status = dictionary["status"] as? String else { return nil }
        self.init(name: name, status: status)
    }
}

