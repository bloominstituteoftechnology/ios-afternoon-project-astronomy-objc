//
//  PhotoList.swift
//  astronomy-objc
//
//  Created by Hector Steven on 7/23/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation


@objc(HSVSolPhoto)
class SolPhoto: NSObject {
	@objc let img_src: String
	@objc let sol: String
	@objc let earthDate: String
	
	@objc let cameraName: String
	
	@objc let roverName: String
	
	
	
	@objc init(img_src: String, sol: String, earthDate: String, cameraName: String, roverName: String) {
		self.img_src = img_src
		self.sol = sol
		self.earthDate = earthDate
		self.cameraName = cameraName
		self.roverName = roverName
	}
}
