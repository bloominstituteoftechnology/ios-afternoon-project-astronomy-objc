//
//  RoverPhotoDetailViewController.swift
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/20/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

import UIKit

class RoverPhotoDetailViewController: UIViewController {

    @IBOutlet var roverPhotoImage: UIImageView!
    
    var photoController = PhotoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let roverToFetch: String = "curiosity"
        let solToFetch: Int = 12
        
        photoController.fetchRoverPhotos(roverToFetch, Int32(solToFetch)) { (data, error) in
            guard let data = data else {
                NSLog("Error returned fetching Rover photos\(error!)")
                return }
            
            DispatchQueue.main.async {
                do {
                    let photoData = try Data(contentsOf: data.roverPhotos[31].photoURL)  // FIXME: Hard-coded a photo by index number
                    self.roverPhotoImage.image = UIImage(data: photoData)
                } catch {
                    NSLog("Error setting up views on detail view controller: \(error)")
                }
            }
            return
        }
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
