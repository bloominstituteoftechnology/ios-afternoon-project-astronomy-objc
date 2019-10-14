//
//  Astronomy_ComboTests.swift
//  Astronomy ComboTests
//
//  Created by Michael Redig on 10/14/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import XCTest
@testable import Astronomy_Combo

class Astronomy_ComboTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func getData() -> Data {
		let bundle = Bundle(for: type(of: self))
		let url = bundle.url(forResource: "RoverManifest", withExtension: "json")!
		let data = try! Data(contentsOf: url)
		return data
	}

	func testData() {
		let data = getData()
		XCTAssertNotNil(data)
		print(data)
	}

	func testRoverInfo() {
		let jsonDict = try! JSONSerialization.jsonObject(with: getData(), options: []) as! [String: Any]

		let info = RoverInfo(dictionary: jsonDict)
		XCTAssertEqual("Curiosity", info?.name)
		XCTAssertEqual(2281, info?.photosReferences.count)
	}

	func testPhotoReference() {
		let jsonDict = try! JSONSerialization.jsonObject(with: getData(), options: []) as! [String: Any]

		let info = RoverInfo(dictionary: jsonDict)

		let firstRover = info?.photosReferences[1]

		XCTAssertEqual(1, firstRover?.sol)
		XCTAssertEqual(16, firstRover?.totalPhotos)
		XCTAssertEqual("MAHLI", firstRover?.cameras.first)
	}

}
