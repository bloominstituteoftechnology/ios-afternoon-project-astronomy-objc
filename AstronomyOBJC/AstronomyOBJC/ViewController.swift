//
//  ViewController.swift
//  AstronomyOBJc
//
//  Created by Kelson Hartle on 7/25/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let controller = LSIMarsRoverController()
    
    var roverO: MarsRover? {
        didSet {
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        controller.fetchMarsRover(withRoverName: "curiosity") { (rover, error) in
            self.roverO = rover
            
            if ((rover) != nil) {
                print("OK")
            } else {
                print("NOT OK")
            }
        }
        
    }

   func updateViews() {
    print(roverO?.name ?? "")
   }
    
    
    
    
    
    

}

