//
//  PhotoDetailViewController.swift
//  Astronomy-ObjC
//
//  Created by scott harris on 4/20/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var solPhotoDetailsLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    
    let apiClient = SAHApiClient();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiClient.fetchManifest { (manifest, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let manifest = manifest {
                print("mainifest: \(manifest)")
                
                let roverName = manifest.name;
                let solId: NSNumber = NSNumber(value: manifest.sols[4].identifier)
                self.apiClient.fetchSolPhotos(forRover: roverName, solId: solId) { (sols, error) in
                    if let error = error {
                        print("Error: \(error)")
                        return
                    }
                    
                    if let sols = sols {
                        print("Sols: \(sols)")
                        let sol = sols[0];
                        print("Sol is: \(sol)")
                        
                        self.apiClient.fetchPhoto(atURL: sol.imageUrl) { (data, error) in
                            if let error = error {
                                print("Error: \(error)")
                                return
                            }
                            
                            guard let data = data else {
                                return
                            }
                            
                            DispatchQueue.main.async {
                                self.imageView.image = UIImage(data: data)
                            }
                        }
                    }
                }
                
                return
            }
        }
    }
    
}
