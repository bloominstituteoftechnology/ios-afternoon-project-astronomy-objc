//
//  PhotoDetailViewController.swift
//  OBJCAstronomyProject
//
//  Created by BrysonSaclausa on 12/2/20.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    //MARK: - IBOUTLETS
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

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

    //MARK: - METHODS
    @IBAction func savePhotoTapped(_ sender: Any) {
    }
    
    
}
