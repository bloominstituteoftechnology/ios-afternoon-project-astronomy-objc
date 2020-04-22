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

        photoController.fetchRoverPhotos("curiosity", 12) { (data, error) in
            guard let data = data else { return }
            print("Data from sol 12, first Image: \(data.roverPhotos[0].photoURL)")
            print("Total photos: \(data.roverPhotos.count)")
            print(data.roverPhotos[0].photoID)
            print(data.roverPhotos[0].sol)
            print(data.roverPhotos[0].cameraName)
            print("Data from sol 12, 32nd Image: \(data.roverPhotos[31].photoURL)")
            print("Total photos: \(data.roverPhotos.count)")
            print(data.roverPhotos[31].photoID)
            print(data.roverPhotos[31].sol)
            print(data.roverPhotos[31].cameraName)
            
            DispatchQueue.main.async {
                do {
                    let photoData = try Data(contentsOf: data.roverPhotos[31].photoURL)
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
