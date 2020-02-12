//
//  PhotosCollectionViewController.swift
//  Astronomy-Hybrid
//
//  Created by Bobby Keffury on 2/12/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    //MARK: - Properties
    
    let solLabel = UILabel()
    
    //ADD THE OTHER PROPERTIES
    
    //MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Views

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //IMPLEMENT THE REST HERE ONCE PROPERTIES FINISH
        
        configureTitleView()
        updateViews()
    }
    
    //MARK: - Collection View Data Source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //IMPLEMENT THE REST HERE ONCE PROPERTIES FINISH
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //IMPLEMENT THE REST HERE ONCE PROPERTIES FINISH
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //IMPLEMENT THE REST HERE ONCE PROPERTIES FINISH
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //IMPLEMENT THE REST HERE ONCE PROPERTIES FINISH
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //IMPLEMENT THE REST HERE ONCE PROPERTIES FINISH
    }
    

    
    //MARK: - Methods
    
    private func configureTitleView() {
        
        let font = UIFont.systemFont(ofSize: 30)
        let attributes = [NSAttributedString.Key.font: font]
        
        
        let prevTitle = NSAttributedString(string: "<", attributes: attributes)
        let prevButton = UIButton(type: .system)
        prevButton.accessibilityIdentifier = "PhotosCollectionViewController.PreviousSolButton"
        prevButton.setAttributedTitle(prevTitle, for: .normal)
        prevButton.addTarget(self, action: #selector(goToPreviousSol(_:)), for: .touchUpInside)
        
        let nextTitle = NSAttributedString(string: ">", attributes: attributes)
        let nextButton = UIButton(type: .system)
        nextButton.accessibilityIdentifier = "PhotosCollectionViewController.NextSolButton"
        nextButton.setAttributedTitle(nextTitle, for: .normal)
        nextButton.addTarget(self, action: #selector(goToNextSol(_:)), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [prevButton, solLabel, nextButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = UIStackView.spacingUseSystem
        
        navigationItem.titleView = stackView
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        solLabel.text = "Sol \(0)" //IMPLEMENT THE REST HERE ONCE PROPERTIES FINISH
    }
    
    //CHANGE THIS TO THE SPECIFIC COLLECTIONVIEWCELL. vvvvvvv
    private func loadImage(forCell cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //IMPLEMENT THE REST HERE ONCE PROPERTIES FINISH
    }
    
    //MARK: - Actions
    
    @IBAction func goToPreviousSol(_ sender: Any?) {
        //IMPLEMENT THE REST HERE ONCE PROPERTIES FINISH
    }
    @IBAction func goToNextSol(_ sender: Any?) {
        //IMPLEMENT THE REST HERE ONCE PROPERTIES FINISH
    }
    
    
    //MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            let detailVC = segue.destination as! PhotoDetailViewController
            //IMPLEMENT THE REST HERE ONCE PROPERTIES FINISH
        }
    }

}
