//
//  PhotosCollectionViewController.swift
//  Astronomy-ObjC
//
//  Created by John Kouris on 2/12/20.
//  Copyright © 2020 John Kouris. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ImageCell"

class PhotosCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTitleView()
        updateViews()
    }
    
    @IBAction func goToPreviousSol(_ sender: Any?) {
//        guard let solDescription = solDescription else { return }
//        guard let solDescriptions = roverInfo?.solDescriptions else { return }
//        guard let index = solDescriptions.firstIndex(of: solDescription) else { return }
//        guard index > 0 else { return }
//        self.solDescription = solDescriptions[index-1]
    }
    
    @IBAction func goToNextSol(_ sender: Any?) {
//        guard let solDescription = solDescription else { return }
//        guard let solDescriptions = roverInfo?.solDescriptions else { return }
//        guard let index = solDescriptions.firstIndex(of: solDescription) else { return }
//        guard index < solDescriptions.count - 1 else { return }
//        self.solDescription = solDescriptions[index+1]
    }
    
    private func configureTitleView() {
        let prevItem = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(goToPreviousSol(_:)))
        prevItem.accessibilityIdentifier = "PhotosCollectionViewController.PreviousSolButton"
        
        let nextItem = UIBarButtonItem(title: ">", style: .plain, target: self, action: #selector(goToNextSol(_:)))
        nextItem.accessibilityIdentifier = "PhotosCollectionViewController.NextSolButton"
        
        navigationItem.setLeftBarButton(prevItem, animated: false)
        navigationItem.setRightBarButton(nextItem, animated: false)
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
//        title = "Sol \(solDescription?.sol ?? 0)"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ImageCollectionViewCell ?? ImageCollectionViewCell()
    
        
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
