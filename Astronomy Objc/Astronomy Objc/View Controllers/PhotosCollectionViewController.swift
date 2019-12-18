//
//  GIPPhotosCollectionViewController.swift
//  Astronomy Objc
//
//  Created by Gi Pyo Kim on 12/17/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import UIKit


private let reuseIdentifier = "ImageCell"

class PhotosCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    let solLabel = UILabel()
    
    private let marsRoverClient = MarsRoverClient()
    private let cache = Cache<NSNumber, UIImage>()
    
    private var rover: MarsRover? {
        didSet {
            if solDescription == nil {
                solDescription = self.rover?.sols[0]
            }
        }
    }
    
    private var solDescription: Sol? {
        didSet {
            if let rover = rover, let sol = solDescription?.sol {
                photoReferences = []
                marsRoverClient.fetchPhoto(rover.name, sol: sol) { (photoRefs, error) in
                    if let error = error {
                        NSLog("Error fetching photos for \(rover.name) on sol \(sol): \(error)")
                        return
                    }
                    self.photoReferences = photoRefs ?? []
                    DispatchQueue.main.async { self.updateViews() }
                }
            }
        }
    }
    
    private var photoReferences = [MarsPhoto]() {
        didSet{
            cache.clear()
            DispatchQueue.main.async { self.collectionView?.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        marsRoverClient.fetchRover("curiosity") { (rover, error) in
            if let error = error {
                NSLog("Error fetching Curiosity: \(error)")
                return
            }
            self.rover = rover
        }
        configureTitleView()
        updateViews()
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        title = "Sol \(solDescription?.sol ?? 0)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoReferences.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ImageCollectionViewCell ?? ImageCollectionViewCell()
        
        // TODO: actually load the image
        print("Image: \(photoReferences[indexPath.row].id)")
        
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
        
        let prevItem = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(goToPreviousSol(_:)))
        prevItem.accessibilityIdentifier = "PhotosCollectionViewController.PreviousSolButton"
        
        let nextTitle = NSAttributedString(string: ">", attributes: attrs)
        let nextButton = UIButton(type: .system)
        nextButton.setAttributedTitle(nextTitle, for: .normal)
        nextButton.addTarget(self, action: #selector(goToNextSol(_:)), for: .touchUpInside)
        nextButton.accessibilityIdentifier = "PhotosCollectionViewController.NextSolButton"
        
        let nextItem = UIBarButtonItem(title: ">", style: .plain, target: self, action: #selector(goToNextSol(_:)))
        nextItem.accessibilityIdentifier = "PhotosCollectionViewController.NextSolButton"
        
        let stackView = UIStackView(arrangedSubviews: [prevButton, solLabel, nextButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = UIStackView.spacingUseSystem
        
        navigationItem.setLeftBarButton(prevItem, animated: false)
        navigationItem.setRightBarButton(nextItem, animated: false)
    }
    
    @IBAction func goToPreviousSol(_ sender: Any?) {
        guard let solDescription = solDescription else { return }
        guard let solDescriptions = rover?.sols else { return }
        guard let index = solDescriptions.firstIndex(of: solDescription) else { return }
        guard index > 0 else { return }
        self.solDescription = solDescriptions[index-1]
    }
    
    @IBAction func goToNextSol(_ sender: Any?) {
        guard let solDescription = solDescription else { return }
        guard let solDescriptions = rover?.sols else { return }
        guard let index = solDescriptions.firstIndex(of: solDescription) else { return }
        guard index < solDescriptions.count - 1 else { return }
        self.solDescription = solDescriptions[index+1]
    }
}

