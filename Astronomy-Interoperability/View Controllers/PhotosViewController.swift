//
//  PhotosViewController.swift
//  Astronomy-Interoperability
//
//  Created by Christian Lorenzo on 6/3/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    //MARK: - Properties:
    
    
    
    @IBOutlet weak var collectonView: UICollectionView!
    @IBOutlet weak var previousSolButton: UIBarButtonItem!
    @IBOutlet weak var nextSolButton: UIBarButtonItem!
    @IBOutlet weak var cameraSegmentedControl: UISegmentedControl!
    

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

}
