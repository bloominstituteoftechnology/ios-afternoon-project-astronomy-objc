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
    @IBOutlet var roverNameTextLabel: UILabel!
    @IBOutlet var photoIDTextLabel: UILabel!
    @IBOutlet var solTextLabel: UILabel!
    @IBOutlet var earthDateTextLabel: UILabel!
    @IBOutlet var cameraNameTextLabel: UILabel!
    
    
    var photoController = PhotoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let roverToFetch: String = "curiosity"
        let solToFetch: Int = 12
        
        photoController.fetchRoverPhotos(roverToFetch, Int32(solToFetch)) { (data, error) in
            guard let data = data else {
                NSLog("Error returned fetching Rover photos\(error!)")
                return }
            
            var dateFormatter: DateFormatter {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
                return formatter
            }
            var dateFormatterString: DateFormatter {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                return formatter
            }
            
            DispatchQueue.main.async {
                do {
                    let earthDateLong: Date = dateFormatter.date(from: String("\(data.roverPhotos[31].earthDate)"))!
                    let earthDateString: String = dateFormatterString.string(from: earthDateLong)
                    
                    let photoData = try Data(contentsOf: data.roverPhotos[31].photoURL) // FIXME: Hard-coded a photo by index number
                    self.roverPhotoImage.image = UIImage(data: photoData)
                    
                    self.roverNameTextLabel.text = String("Rover - \(roverToFetch.capitalized)")
                    self.solTextLabel.text = String("Mission Sol: \(solToFetch)")
                    self.photoIDTextLabel.text = String("Photo ID: \(data.roverPhotos[31].photoID)")
                    self.earthDateTextLabel.text = String("Earth Date: \(earthDateString)")
//                    print(data.roverPhotos[31].earthDate)
                    self.cameraNameTextLabel.text = data.roverPhotos[31].cameraName
                } catch {
                    NSLog("Error setting up views on detail view controller: \(error)")
                }
            }
            return
        }
    }
    
    @IBAction func savePhotoToLibrary(_ sender: UIButton) {
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
