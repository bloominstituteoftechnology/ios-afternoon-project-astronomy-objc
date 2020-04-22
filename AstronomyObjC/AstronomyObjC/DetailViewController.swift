//
//  ViewController.swift
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/21/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit
extension UIImageView {
    func enableZoom() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(pinchGesture)
    }
    
//    func enableRotate() {
//        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotate(_:)))
//        addGestureRecognizer(rotateGesture)
//    }
    
  
     @objc private func startZooming(_ sender: UIPinchGestureRecognizer) {
        let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
        guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
        sender.view?.transform = scale
        sender.scale = 1
    
    }
  

}
class DetailViewController: UIViewController {

    //MARK:- Outlets
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = imageView.bounds.size.height / 2
            imageView.layer.masksToBounds = true
            imageView.layer.borderWidth = 2
            
            imageView.layer.borderColor = UIColor.gray.cgColor
          
        }
    }
    @objc func handlePinch() {
        print("Hell")
    }
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
        imageView.enableZoom()
        imageView.isUserInteractionEnabled = true
      
        fetcher.fetchOneSingleSol { (sols, _) in
            guard let solTen = sols?.first else { return }
                DispatchQueue.main.async {
                    self.updateViews(for: solTen)
                }
             
            
        }
      
    }

    private func updateViews(for sol: MarsSol) {
        self.cameraLabel.text = sol.camera.name
        self.dateTakenLabel.text = "Taken by \(sol.idNumber) on  \(self.dateFormatter.string(from: (sol.earthDate))) (Sol \(sol.sol))"
        self.imageView.load(url: (URL(string: (sol.imageURL))?.usingHTTPS!)!)
    }

}
