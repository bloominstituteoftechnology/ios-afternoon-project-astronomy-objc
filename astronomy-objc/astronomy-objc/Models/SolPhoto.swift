//
//  PhotoList.swift
//  astronomy-objc
//
//  Created by Hector Steven on 7/23/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

class SolPhoto: NSObject {
	@objc let img_src: String
	@objc let sol: String
	@objc let earthDate: String
	@objc let cameraName: String
	@objc let roverName: String
	
	
	
	init(img_src: String, sol: String, earthDate: String, cameraName: String, roverName: String) {
		self.img_src = img_src
		self.sol = sol
		self.earthDate = earthDate
		self.cameraName = cameraName
		self.roverName = roverName
	}

/*
	
	NSString *earthDate = dict[@"earth_date"];
	NSURL *img_src = dict[@"img_src"];
	
	*/
	
	@objc convenience init?(dictionary: [String : Any]) {
		
		guard let imgSrc = dictionary["img_src"] as? String,
			let sol = dictionary["sol"] as? String,
			let earthDate = dictionary["earth_date"] as? String,
			let camera = dictionary["camera"] as? [String : Any], let cameraName = camera["name"] as? String,
			let rover =  dictionary["rover"] as? [String: Any], let roverName = rover["name"] as? String else { return nil}
		
		
		self.init(img_src: imgSrc, sol:sol, earthDate:earthDate, cameraName: cameraName, roverName: roverName)
	}
	
}
