//
//  RoverDetailViewController.swift
//  Astronomy in OBJC
//
//  Created by Sal B Amer on 6/4/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

import UIKit

class RoverDetailViewController: UIViewController {

  //MARK: IBOutletss
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var photoDetailsLabel: UILabel!
  @IBOutlet weak var whichCameraUsedLabel: UILabel!
  
  var marsPhotoRef : MarsPhotos?
  var roverAPIController: RoverAPIController?
  
    override func viewDidLoad() {
        super.viewDidLoad()

       updateViews()
    }
  
  func updateViews() {
    guard let marsPhotoRef = marsPhotoRef,
      let roverAPIController = roverAPIController else { return }
    
    let date = marsPhotoRef.earthDate
    
    roverAPIController.fetchImages(forPhotoRef: marsPhotoRef) { (data, error) in
      DispatchQueue.main.async {
        guard let data = data else { return }
        self.imageView.image = UIImage(data: data)
      }
      self.photoDetailsLabel.text = "Taken by: \(marsPhotoRef.identification) on \(date) (Sol \(marsPhotoRef.sol))"
      self.whichCameraUsedLabel.text = "Camera: \(marsPhotoRef.camera) Camera"
    }
    
    
  }
    
  //MARK: IBACTIONS

  @IBAction func savePhotoBtnPressed(_ sender: Any) {
  }
  
}
