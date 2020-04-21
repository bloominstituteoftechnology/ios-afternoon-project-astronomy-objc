//
//  ViewController.swift
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/21/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK:- Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateTakenLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBAction func savePressed(_ sender: UIButton) {  }
    //MARK:- Properties
    
    private var fetcher = SolFetcher()
    
    private lazy var dateFormatter: DateFormatter = {
       let dm = DateFormatter()
        dm.calendar = .current
        dm.dateStyle = .short
        return dm
    }()
    //MARK:- Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetcher.fetchOneSingleSol { (sols, _) in
            sols?.forEach({ (sol) in
                DispatchQueue.main.async {
                    
                    self.cameraLabel.text = "Camera: \(sol.camera.name)"
                    self.dateTakenLabel.text = "Taken by \(sol.idNumber) on  \(self.dateFormatter.string(from: sol.earthDate)) Sol \(sol.sol)"
                    self.imageView.load(url: (URL(string: sol.imageURL)?.usingHTTPS!)!)
                }
             
            })
        }
      
    }


}
