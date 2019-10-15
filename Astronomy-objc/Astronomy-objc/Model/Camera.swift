//
//  Camera.swift
//  Astronomy-objc
//
//  Created by Bradley Yin on 10/14/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

//@objc(BYCamera)
class Camera: NSObject {
    let id: Int
    let name: String
    let roverId: Int
    let fullName: String
    
    @objc init(id: Int, name: String, roverId: Int, fullName: String) {
        self.id = id
        self.name = name
        self.fullName = fullName
        self.roverId = roverId
    }
}
