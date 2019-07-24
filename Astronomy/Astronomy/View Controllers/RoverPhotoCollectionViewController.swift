//
//  RoverPhotoCollectionViewController.swift
//  Astronomy
//
//  Created by Christopher Aronson on 7/23/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import UIKit

class RoverPhotoCollectionViewController: UICollectionViewController {
    
    let solLabel = UILabel()
    let roverController = RoverController()
    var currentSolIndex = 0;
    var currentSol: Sol? {
        didSet {
            self.callPhotosInfoFetch()
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roverController.fetchSol { error in
            
            if let error = error {
                print("There was an error getting sols from nasa: \(error)")
            }
            
            DispatchQueue.main.async {
                self.selectSol()
            }
        }
        
        collectionView.reloadData()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roverController.photoURLs.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        
        print("Loading Image")
        
        cell.photoURL = roverController.photoURLs[indexPath.row].photoURL
        cell.roverController = roverController
        
        cell.photoImageView.image = #imageLiteral(resourceName: "Blank")
        
        cell.loadImage()
        
        return cell
    }

    private func configureTitleView() {
        
        let font = UIFont.systemFont(ofSize: 30)
        let attrs = [NSAttributedString.Key.font: font]
        
        let prevTitle = NSAttributedString(string: "<", attributes: attrs)
        let prevButton = UIButton(type: .system)
        prevButton.accessibilityIdentifier = "PhotosCollectionViewController.PreviousSolButton"
        prevButton.setAttributedTitle(prevTitle, for: .normal)
        prevButton.addTarget(self, action: #selector(goToPreviousSol(_:)), for: .touchUpInside)
        
        let nextTitle = NSAttributedString(string: ">", attributes: attrs)
        let nextButton = UIButton(type: .system)
        nextButton.setAttributedTitle(nextTitle, for: .normal)
        nextButton.addTarget(self, action: #selector(goToNextSol(_:)), for: .touchUpInside)
        nextButton.accessibilityIdentifier = "PhotosCollectionViewController.NextSolButton"
        
        let stackView = UIStackView(arrangedSubviews: [prevButton, solLabel, nextButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = UIStackView.spacingUseSystem
        
        navigationItem.titleView = stackView
    }
    
    private func setSolLabel() {
        
        guard let solNumber = currentSol?.sol.intValue else { return }
        
        solLabel.text = "sol: \(solNumber)"
    }
    
    private func selectSol() {
        
        currentSol = roverController.sols[currentSolIndex]
        collectionView.reloadData()
    }
    
    private func callPhotosInfoFetch() {
        
        guard let sol = currentSol?.sol else { return }
        
        roverController.fetchPhotos(fromSol: sol) { (error) in
            
            DispatchQueue.main.async {
                self.setSolLabel()
                self.configureTitleView()
                self.collectionView.reloadData()
            }
        }
    }
    
    @IBAction func goToPreviousSol(_ sender: Any?) {
        
        if currentSolIndex == 0 {
            return
        }
        
        currentSolIndex -= 1
        
        selectSol()
        setSolLabel()
        collectionView.reloadData()
    }
    
    @IBAction func goToNextSol(_ sender: Any?) {
        
        if currentSolIndex == (roverController.sols.count - 1) {
            return
        }
        
        currentSolIndex += 1
        
        selectSol()
        setSolLabel()
        collectionView.reloadData()
    }
}


