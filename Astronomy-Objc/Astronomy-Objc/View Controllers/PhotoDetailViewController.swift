//
//  PhotoDetailViewController.swift
//  Astronomy-Objc
//
//  Created by Michael on 3/24/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    var photo: MBMPhoto? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func updateViews() {
        
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
