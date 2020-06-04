//
//  MarsRover.swift
//  Astronomy in OBJC
//
//  Created by Sal B Amer on 6/4/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

import Foundation

@objcMembers class Rover: NSObject {
  var name: String
  var photos: String?
  
  init(name: String, photos: String?) {
    self.name = name
    self.photos = photos
  }
}
