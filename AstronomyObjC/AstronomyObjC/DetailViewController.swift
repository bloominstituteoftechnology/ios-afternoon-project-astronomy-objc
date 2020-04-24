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
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = imageView.bounds.size.height / 2
            imageView.layer.masksToBounds = true
            imageView.layer.borderWidth = 2
            imageView.contentMode = .scaleToFill
            imageView.layer.borderColor = UIColor.gray.cgColor
          
        }
    }
    @objc func handlePinch() {
       
    }
    @IBOutlet weak var dateTakenLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBAction func savePressed(_ sender: UIButton) {  }
    //MARK:- Properties
    
    private var fetcher = SolFetcher()
    var sol: MarsSol?
    private lazy var dateFormatter: DateFormatter = {
       let dm = DateFormatter()
        dm.calendar = .current
        dm.dateStyle = .short
        return dm
    }()
    //MARK:- Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let sol = sol {
            updateViews(for: sol)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.enableZoom()
        imageView.isUserInteractionEnabled = true
   
    }
//MARK:- Private
    
    private func updateViews(for sol: MarsSol) {
        self.navigationItem.title = "Sol Id: \(sol.idNumber)"
        self.cameraLabel.text = "Camera : \(sol.camera.name)"
        self.dateTakenLabel.text = "Taken by \(sol.idNumber) on  \(self.dateFormatter.string(from: (sol.earthDate))) (Sol \(sol.sol))"
        if let image = MainCollectionViewController.nsCache.object(forKey: sol.idNumber) {
            imageView.image = image
        } else {
           
              self.imageView.load(url: (URL(string: (sol.imageURL))?.usingHTTPS!)!)
        }
      
    }

}
