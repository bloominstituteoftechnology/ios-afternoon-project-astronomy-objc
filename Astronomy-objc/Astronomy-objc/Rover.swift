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
    
    @objc init(name: String, status: String) {
        self.name = name
        self.status = status
    }
}
