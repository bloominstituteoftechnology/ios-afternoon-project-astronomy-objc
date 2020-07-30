//
//  FilterImageOperation.swift
//  AstronomyOBJc
//
//  Created by Kelson Hartle on 7/30/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

import Foundation

class FilterImageOperation: Operation {
    init(fetchOperation: PhotoFetcherOperation) {
        self.fetchOperation = fetchOperation
    }
    
    override func main() {
        let data = fetchOperation.imageData
        let image = UIImage(data: data)
        self.image = image?.filtered()
        NSLog("Image Filtered.")
        
    }
    
//    override func main() {
//        if let data = fetchOperation.imageData,
//            let image = UIImage(data: data) {
//            self.image = image.filtered()
//            NSLog("Finished filtering image")
//        }
//    }
    
    let fetchOperation: PhotoFetcherOperation
    private(set) var image: UIImage?
}
