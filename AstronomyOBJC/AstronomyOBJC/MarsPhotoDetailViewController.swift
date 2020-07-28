//
//  MarsPhotoDetailViewController.swift
//  AstronomyOBJc
//
//  Created by Kelson Hartle on 7/27/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

import UIKit

class MarsPhotoDetailViewController: UIViewController {
    
    //MARK: - Properties
    let controller = LSIMarsRoverController()
    
    var reference: LSIMarsRoverPhotoReference? {
        didSet {
            updateViews()
        }
    }
    
    
    //MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var solDetailLabel: UILabel!
    @IBOutlet weak var cameraTypeLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        controller.fetchMarsRoverPhotos(fromRover: "curiosity", onSol: 6) { (photos, error) in
            self.reference = photos
            if ((photos) != nil) {
                print("OK")
            } else {
                print("NOT OK")
            }
        }
    }
    
    private func updateViews() {
        
        DispatchQueue.main.async {
            guard let reference = self.reference, self.isViewLoaded else { return }
            do {
                let data = try Data(contentsOf: reference.imageSource.usingHTTPS!)
                self.imageView.image = UIImage(data: data)
                self.cameraTypeLabel.text = reference.camera.name
                self.solDetailLabel.text = "Taken by \(reference.identifier) on \(reference.earthDate), (Sol \(reference.sol))"
            } catch {
                NSLog("Error setting up views on detail view controller: \(error)")
            }
        }
    }
    
    static func dateFormatter() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
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
