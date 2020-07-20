//
//  Rover.swift
//  Astronomy Objc
//
//  Created by Vincent Hoang on 7/20/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import UIKit

@objc class Rover: NSObject {
    @objc let id: Int
    @objc let name: String
    @objc let landing_date: String
    @objc let launch_date: String
    @objc let status: String
    
    @objc init(_ id: Int, _ name: String, _ landing_date: String, _ launch_date: String, _ status: String) {
        self.id = id
        self.name = name
        self.landing_date = landing_date
        self.launch_date = launch_date
        self.status = status
    }
}
