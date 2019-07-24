//
//  PhotoList.swift
//  astronomy-objc
//
//  Created by Hector Steven on 7/23/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

class SolPhoto: NSObject {
	let img_src: String
	let sol: String
	let earthDate: String
	
	let cameraName: String
	
	let roverName: String
	
	
	
	init(img_src: String, sol: String, earthDate: String, cameraName: String, roverName: String) {
		self.img_src = img_src
		self.sol = sol
		self.earthDate = earthDate
		self.cameraName = cameraName
		self.roverName = roverName
	}
}
