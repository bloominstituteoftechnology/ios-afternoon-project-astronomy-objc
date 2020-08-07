//
//  PhotoDetailViewController.swift
//  Astronomy
//
//  Created by Claudia Maciel on 8/7/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var cameraLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var photo: Photo?
    
    lazy var dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        activityIndicator.startAnimating()
        guard let photo = photo,
            let imageData = try? Data(contentsOf: photo.imgURL) else { return }
        
        imageView.image = UIImage(data: imageData)
        detailLabel.text = "Taken by rover # \(photo.rover.id) on \(dateFormatter.string(from: photo.earthDate)) (Sol: \(photo.sol))"
        cameraLabel.text = "Camera: \(photo.camera)"
        activityIndicator.stopAnimating()
    }

    @IBAction func saveToLibraryButtonTapped(_ sender: Any) {
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
