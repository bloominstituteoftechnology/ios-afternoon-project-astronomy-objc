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
    var currentSol: Sol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roverController.fetchSol { error in
            
            if let error = error {
                print("There was an error getting sols from nasa: \(error)")
            }
            
            DispatchQueue.main.async {
                self.selectSol()
                self.setSolLabel()
                self.configureTitleView()
            }
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
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
    }
    
    @IBAction func goToPreviousSol(_ sender: Any?) {
        
        if currentSolIndex == 0 {
            return
        }
        
        currentSolIndex -= 1
        
        selectSol()
        setSolLabel()
    }
    
    @IBAction func goToNextSol(_ sender: Any?) {
        
        if currentSolIndex == (roverController.sols.count - 1) {
            return
        }
        
        currentSolIndex += 1
        
        selectSol()
        setSolLabel()
    }
}
