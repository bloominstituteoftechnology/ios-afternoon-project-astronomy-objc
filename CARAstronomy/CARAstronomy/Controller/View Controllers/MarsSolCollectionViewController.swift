//
//  MarsSolCollectionViewController.swift
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/24/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

import UIKit

class MarsSolCollectionViewController: UICollectionViewController {
    
    let manifestFetcher = ManifestFetcher()
    var manifest: MarsMissionManifest?
    let solFetcher = SolFetcher()
    let photoQueue = OperationQueue()
    var sols = [MarsSol]()
    var solToSend: MarsSol?
    private let solLabel = UILabel()
    private var solIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitleView()
        loadPhotos()
    }
    
    private func configureTitleView() {
        let font = UIFont.systemFont(ofSize: 30)
        let attributes = [NSAttributedString.Key.font: font]
        
        let prevTitle = NSAttributedString(string: "<", attributes: attributes)
        let prevButton = UIButton(type: .system)
        prevButton.accessibilityIdentifier = "MarsSolCollectionViewController.PreviousSolButton"
        prevButton.setAttributedTitle(prevTitle, for: .normal)
        prevButton.addTarget(self, action: #selector(goToPreviousSol(_:)), for: .touchUpInside)
        
        let nextTitle = NSAttributedString(string: ">", attributes: attributes)
        let nextButton = UIButton(type: .system)
        nextButton.accessibilityIdentifier = "MarsSolCollectionViewController.NextSolButton"
        nextButton.setAttributedTitle(nextTitle, for: .normal)
        nextButton.addTarget(self, action: #selector(goToNextSol(_:)), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [prevButton, solLabel, nextButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = UIStackView.spacingUseSystem
        
        navigationItem.titleView = stackView
    }
    
    private func loadPhotos() {
        let manifestFetchOperation = FetchManifestOperation(manifestFetcher: manifestFetcher)
        let photoOperation = BlockOperation {
            guard let manifest = manifestFetchOperation.manifest, let sol = manifest.sols[self.solIndex] as? NSNumber else { return }
            self.solFetcher.fetchPhotos(forRover: "curiosity", withSol: sol) { sols, error in
                guard error == nil else { return }
                guard let sols = sols as? [MarsSol] else { return }
                self.sols = sols
                self.solLabel.text = "Sol \(sol)"
                self.collectionView.reloadData()
            }
        }
        
        photoOperation.addDependency(manifestFetchOperation)
        photoQueue.addOperation(manifestFetchOperation)
        OperationQueue.main.addOperation(photoOperation)
    }
    
    @objc private func goToPreviousSol(_ sender: Any) {
        solIndex = (solIndex <= 0) ? 0 : solIndex - 1
        setSol()
    }
    
    @objc private func goToNextSol(_ sender: Any) {
        solIndex = (solIndex >= sols.count - 1) ? sols.count : solIndex + 1
        setSol()
    }
    
    private func setSol() {
        if solIndex < sols.count && solIndex >= 0 {
            let manifestFetchOperation = FetchManifestOperation(manifestFetcher: manifestFetcher)
            let photoOperation = BlockOperation {
                guard let manifest = manifestFetchOperation.manifest, let sol = manifest.sols[self.solIndex] as? NSNumber else { return }
                self.solFetcher.fetchPhotos(forRover: "curiosity", withSol: sol) { sols, error in
                    guard error == nil else { return }
                    guard let sols = sols as? [MarsSol] else { return }
                    self.sols = sols
                    self.solLabel.text = "Sol \(sol)"
                    self.collectionView.reloadData()
                }
            }
            
            photoOperation.addDependency(manifestFetchOperation)
            photoQueue.addOperation(manifestFetchOperation)
            OperationQueue.main.addOperation(photoOperation)
        }
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segues.showSolDetailSegue:
            guard let detailVC = segue.destination as? MarsSolDetailViewController else { return }
            detailVC.sol = solToSend
        default:
            break
        }
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sols.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SolCell", for: indexPath) as? CARMarsSolCollectionViewCell else { return UICollectionViewCell() }
        let sol = sols[indexPath.item]
        guard let url = URL(string: sol.imageURL)?.usingHTTPS else { return UICollectionViewCell() }
        cell.configureCell(withImageURL: url)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sol = sols[indexPath.item]
        self.solToSend = sol
        performSegue(withIdentifier: Segues.showSolDetailSegue, sender: self)
    }
}

extension MarsSolCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        var totlaUsableWidth = collectionView.frame.width
        let inset = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
        totlaUsableWidth -= inset.left + inset.right
        
        let minWidth: CGFloat = 150.0
        let numberOfItemsInOneRow = Int(totlaUsableWidth / minWidth)
        totlaUsableWidth -= CGFloat(numberOfItemsInOneRow - 1) * flowLayout.minimumInteritemSpacing
        let width = totlaUsableWidth / CGFloat(numberOfItemsInOneRow)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 10.0)
    }
}
