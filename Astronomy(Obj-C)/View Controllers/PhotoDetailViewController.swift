//
//  PhotoDetailViewController.swift
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-27.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var photoInfoLabel: UILabel!
    @IBOutlet weak var cameraInfoLabel: UILabel!

//    var photoController: PhotoController?
    var photoRef: PhotoReference?
    var sol: Sol?
    var image: UIImage?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }

    private func updateViews() {
        guard
            isViewLoaded,
            let sol = sol,
            let photoRef = photoRef
            else { return }
        imageView.image = image
        photoInfoLabel.text = "Taken by Curiosity on \(sol.earthDate) (Sol \(sol.marsSol))"
        cameraInfoLabel.text = "Camera: \(photoRef.cameraName)"
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
