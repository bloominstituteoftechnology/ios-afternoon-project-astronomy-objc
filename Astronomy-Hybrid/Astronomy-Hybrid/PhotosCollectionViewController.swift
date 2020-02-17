//
//  PhotosCollectionViewController.swift
//  Astronomy-Hybrid
//
//  Created by Vici Shaweddy on 2/12/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ImageCell"

class PhotosCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let solLabel = UILabel()
    
    private let client = MarsRoverClient()
    private let cache = Cache<NSNumber, UIImage>()
    private let photoFetchQueue = OperationQueue()
    private let photoFilterQueue = OperationQueue()
    private var operations = [Int : Operation]()
    
    var photo: MarsPhotoReference? {
        didSet {
            self.updateViews()
        }
    }
   
    private var roverInfo: MarsRover? {
        didSet {
            self.solDescription = self.roverInfo?.solDescription[10]
        }
    }
    
    private var photoReferences = [MarsPhotoReference]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private var solDescription: SolDescription? {
        didSet {
            if let rover = roverInfo,
                let sol = self.solDescription?.sol {
                self.photoReferences = []
                self.client.fetchPhotos(from: rover, onSol: sol, session: URLSession.shared) { (photoRefs, error) in
                    if let error = error {
                        NSLog("Error fetching photos for \(rover.name) on sol \(sol): \(error)")
                        return
                    }
                    self.photoReferences = photoRefs ?? []
                    DispatchQueue.main.async {
                        self.updateViews()
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.client.fetchMarsRover(withName: "curiosity", session: nil) { (rover, error) in
            if let error = error {
                NSLog("Error fetching info for curiosity: \(error)")
                return
            }
            
            self.roverInfo = rover
        }
        
        self.configureTitleView()
        self.updateViews()
    }
    
    @IBAction func goToPreviousSol(_ sender: Any?) {
        guard let solDescription = solDescription else { return }
        guard let solDescriptions = roverInfo?.solDescription else { return }
        guard let index = solDescriptions.firstIndex(of: solDescription) else { return }
        guard index > 0 else { return }
        self.solDescription = solDescriptions[index-1]
    }
    
    @IBAction func goToNextSol(_ sender: Any?) {
        guard let solDescription = solDescription else { return }
        guard let solDescriptions = roverInfo?.solDescription else { return }
        guard let index = solDescriptions.firstIndex(of: solDescription) else { return }
        guard index < solDescriptions.count - 1 else { return }
        self.solDescription = solDescriptions[index+1]
    }

    // MARK: - Private Func
    
    private func updateViews() {
        guard isViewLoaded else { return }
        solLabel.text = "Sol \(solDescription?.sol ?? 0)"
    }
    
    private func configureTitleView() {
        let font = UIFont.systemFont(ofSize: 30)
        let attrs = [NSAttributedString.Key.font: font]

        let prevButton = UIButton(type: .system)
        let prevTitle = NSAttributedString(string: "<", attributes: attrs)
        prevButton.setAttributedTitle(prevTitle, for: .normal)
        prevButton.addTarget(self, action: #selector(goToPreviousSol(_:)), for: .touchUpInside)

        let nextButton = UIButton(type: .system)
        let nextTitle = NSAttributedString(string: ">", attributes: attrs)
        nextButton.setAttributedTitle(nextTitle, for: .normal)
        nextButton.addTarget(self, action: #selector(goToNextSol(_:)), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [prevButton, solLabel, nextButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = UIStackView.spacingUseSystem

        navigationItem.titleView = stackView
    }
    
    private func loadImage(forCell cell: ImageCollectionViewCell, forItemAt indexPath: IndexPath) {
        let photoReference = self.photoReferences[indexPath.item]
        
        // Check for image in cache
        if let cachedImage = cache.getObjectForKey(NSNumber(integerLiteral: photoReference.id)) {
            cell.imageView.image = cachedImage
            return
        }
        
        guard let url = photoReference.imageURL.usingHTTPS else { return }
        
        // Start an operation to fetch image data
        let fetchOp = PhotoFetchOperation(url: url)

        
        let cacheOp = BlockOperation {
            if let image = fetchOp.photo {
                self.cache.cache(image, forKey: NSNumber(integerLiteral: photoReference.id))
            }
        }
        
        let completionOp = BlockOperation {
            defer { self.operations.removeValue(forKey: photoReference.id) }
            
            if let currentIndexPath = self.collectionView.indexPath(for: cell),
                currentIndexPath != indexPath {
                return // Cell has been reused
            }
            
            if let image = fetchOp.photo {
                cell.imageView.image = image
            }
        }
        
        cacheOp.addDependency(fetchOp)
        completionOp.addDependency(fetchOp)
        
        self.photoFetchQueue.addOperation(fetchOp)
        self.photoFetchQueue.addOperation(cacheOp)
        OperationQueue.main.addOperation(completionOp)
        
        // if the user pass scrolling it, cancel the operation
        operations[photoReference.id] = fetchOp
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            let detailVC = segue.destination as! PhotoDetailViewController
            detailVC.photo = photoReferences[indexPath.item]
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        NSLog("num photos: \(photoReferences.count)")
        return photoReferences.count
    }

    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if photoReferences.count > 0 {
            let photoRef = photoReferences[indexPath.item]
            operations[photoRef.id]?.cancel()
        } else {
            for (_, operation) in operations {
                operation.cancel()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCollectionViewCell ?? ImageCollectionViewCell()
        
        loadImage(forCell: cell, forItemAt: indexPath)
        return cell
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
}
