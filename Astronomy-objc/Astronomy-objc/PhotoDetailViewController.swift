//
//  PhotoDetailViewController.swift
//  Astronomy-objc
//
//  Created by Dillon P on 4/26/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    @IBOutlet weak var marsRoverPhoto: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let marsRoverManifestController = MarsRoverManifestController()
        
        marsRoverManifestController.fetchSingleImage("https://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/00030/opgs/edr/ncam/NRA_400165599EDR_F0040000NCAM00106M_.JPG") { (image, error) in
            if let error = error {
                print(error)
            }
            
            if let image = image {
                self.marsRoverPhoto.image = image
            }
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
