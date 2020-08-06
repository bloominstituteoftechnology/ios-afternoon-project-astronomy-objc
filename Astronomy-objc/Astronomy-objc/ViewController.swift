//
//  ViewController.swift
//  Astronomy-objc
//
//  Created by Matthew Martindale on 8/5/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let manifestController = FetchManifest()

    override func viewDidLoad() {
        super.viewDidLoad()

        let rover = "curiosity"
        manifestController.fetchRoverManifest(rover) { (rover, error) in
            guard error == nil else {
                print("Error fetching rover manifest in VC: \(error!)")
                return
            }
            
            print(rover?.name)
            print(rover?.status)
        }
    }
    

}
