//
//  MarsRoverPhotosCollectionViewController.swift
//  AstronomyOBJc
//
//  Created by Kelson Hartle on 7/28/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MarsPhotoCell"

class MarsRoverPhotosCollectionViewController: UICollectionViewController {
    
    let controller = LSIMarsRoverController()
    // TODO: Implement cache
    //private let cache = Cache<Int,Data>()
    private let photoFetchQueue = OperationQueue() //This is a background queue //main thread is serial queue
    private var operations = [Int: Operation]()
    
    private let solLabel = UILabel()
    
    
    //MARK: - Outlets
    @IBOutlet weak var previousSolButton: UIBarButtonItem!
    @IBOutlet weak var nextSolButton: UIBarButtonItem!
    
    //MARK: - Actions
    @IBAction func previousSolButtonTapped(_ sender: Any) {
        guard let solDescription = solDetails else { return }
        guard let solDescriptions = roverInfoReturnedFromServer?.solDetails else { return }
        guard let index = solDescriptions.firstIndex(of: solDescription) else { return }
        guard index > 0 else { return }
        self.solDetails = solDescriptions[index-1]
        
    }
    
    @IBAction func nextSolButtonTapped(_ sender: Any) {
        guard let solDescription = solDetails else { return }
        guard let solDescriptions = roverInfoReturnedFromServer?.solDetails else { return }
        guard let index = solDescriptions.firstIndex(of: solDescription) else { return }
        guard index < solDescriptions.count - 1 else { return }
        self.solDetails = solDescriptions[index+1]
    }
    
    
    
    private var roverInfoReturnedFromServer: MarsRover? {
        didSet {
            solDetails = roverInfoReturnedFromServer?.solDetails[1]
        }
    }
    
    private var solDetails: LSISolDetails? {
        didSet {
            if let rover = roverInfoReturnedFromServer,
                let sol = solDetails?.solNumber {
                controller.fetchMarsRoverPhotos(from: rover, onSol: sol) { (photoReferences, error) in
                    if let error = error { NSLog("Error fetching photos for \(rover.name) on sol \(sol): \(error)"); return }
                    
                }
            }
        }
    }
    
    private var photoReferences = [LSIMarsRoverPhotoReference]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        controller.fetchMarsRover(withRoverName: "curiosity") { (rover, error) in
            if let error = error {
                NSLog("Error fetching info for curiosity: \(error)")
                return
            }
            self.roverInfoReturnedFromServer = rover
        }
    }

    
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photoReferences.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
//        loadImage()
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if photoReferences.count > 0 {
            let photoRef = photoReferences[indexPath.item]
            operations[Int(truncating: photoRef.identifier)]?.cancel()
        } else {
            for (_, operation) in operations {
                operation.cancel()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        var totalUsableWidth = collectionView.frame.width
        let inset = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
        totalUsableWidth -= inset.left + inset.right
        
        let minWidth: CGFloat = 150.0
        let numberOfItemsInOneRow = Int(totalUsableWidth / minWidth)
        totalUsableWidth -= CGFloat(numberOfItemsInOneRow - 1) * flowLayout.minimumInteritemSpacing
        let width = totalUsableWidth / CGFloat(numberOfItemsInOneRow)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 10.0)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMarsDetailSegue" {
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            guard let destinationVC = segue.destination as? MarsPhotoDetailViewController else { return }
            
            destinationVC.reference = photoReferences[indexPath.item]
        }
    }
    
    private func udpateViews() {
        guard isViewLoaded else { return }
        solLabel.text = "Sol \(solDetails?.solNumber ?? 0)"
        
    }
    
    private func setUpNavigationBar() {
        
        let font = UIFont.systemFont(ofSize: 30)
        let attrs = [NSAttributedString.Key.font: font]

        let prevTitle = NSAttributedString(string: "<", attributes: attrs)
        let prevButton = UIButton(type: .system)
        prevButton.accessibilityIdentifier = "PhotosCollectionViewController.PreviousSolButton"
        prevButton.setAttributedTitle(prevTitle, for: .normal)
        prevButton.addTarget(self, action: #selector(previousSolButtonTapped(_:)), for: .touchUpInside)
        
        let nextTitle = NSAttributedString(string: ">", attributes: attrs)
        let nextButton = UIButton(type: .system)
        nextButton.setAttributedTitle(nextTitle, for: .normal)
        nextButton.addTarget(self, action: #selector(nextSolButtonTapped(_:)), for: .touchUpInside)
        nextButton.accessibilityIdentifier = "PhotosCollectionViewController.NextSolButton"
        
        let stackView = UIStackView(arrangedSubviews: [prevButton, solLabel, nextButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = UIStackView.spacingUseSystem
        
        navigationItem.titleView = stackView
    }
    
    
    

}
