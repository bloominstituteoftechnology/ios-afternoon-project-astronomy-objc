//
//  MainCollectionViewController.swift
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-27.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PhotoCell"

class MainCollectionViewController: UICollectionViewController {

    private let solLabel = UILabel()

    private let photoController = PhotoController()
    private var currentSolIndex: Int = 0
    private var currentSol: Sol?
    private var photoReferences: [PhotoReference] = []

    private var photos: [PhotoReference: UIImage] = [:]


    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTitleView()
        fetchManfest()
    }

    private func configureTitleView() {
        let font = UIFont.systemFont(ofSize: 30)
        let attributes = [NSAttributedString.Key.font: font]

        let prevTitle = NSAttributedString(string: "<", attributes: attributes)
        let prevButton = UIButton(type: .system)
        prevButton.accessibilityIdentifier = "MainCollectionViewController.PreviousSolButton"
        prevButton.setAttributedTitle(prevTitle, for: .normal)
        prevButton.addTarget(self, action: #selector(goToPreviousSol(_:)), for: .touchUpInside)

        let nextTitle = NSAttributedString(string: ">", attributes: attributes)
        let nextButton = UIButton(type: .system)
        nextButton.setAttributedTitle(nextTitle, for: .normal)
        nextButton.addTarget(self, action: #selector(goToNextSol(_:)), for: .touchUpInside)
        nextButton.accessibilityIdentifier = "MainCollectionViewController.NextSolButton"

        let stackView = UIStackView(arrangedSubviews: [prevButton, solLabel, nextButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = UIStackView.spacingUseSystem

        navigationItem.titleView = stackView
    }

    private func fetchManfest() {
        photoController.fetchMissionManifest { error in
            if let error = error {
                NSLog("Error fetching mission manifest: \(error)")
                return
            }

            if let sol10Index = self.photoController.sols.firstIndex(where: { $0.marsSol == 10 }) {
                self.currentSolIndex = sol10Index
                self.setCurrentSol()
            }
            DispatchQueue.main.async { self.updateViews() }
        }
    }

    private func updateViews() {
        if let sol = currentSol {
            self.solLabel.text = "Sol \(sol.marsSol)"
        }

        self.collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return photoReferences.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                 for: indexPath) as? PhotoCollectionViewCell
            else { return UICollectionViewCell() }

        let photoRef = photoReferences[indexPath.row]
        cell.photoController = self.photoController
        cell.photoRef = photoRef

        if let image = self.photos[photoRef] {
            cell.imageView.image = image
        } else {
            photoController.fetchPhoto(for: photoRef) { image, error in
                if let error = error {
                    NSLog("Error fetching photo: \(error)")
                    return
                }
                self.photos[photoRef] = image

                guard cell.photoRef == photoRef else { return }
                DispatchQueue.main.async {
                    cell.imageView.image = image
                }
            }
        }

    
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PhotoDetailSegue",
            let detailVC = segue.destination as? PhotoDetailViewController,
            let index = collectionView.indexPathsForSelectedItems?.first?.row {
            let photoRef = photoReferences[index]
            
            detailVC.photoRef = photoRef
            detailVC.image = photos[photoRef]
            detailVC.sol = currentSol
        }
    }

    // MARK: - Private Helpers

    @objc
    private func goToPreviousSol(_ sender: Any) {
        currentSolIndex -= (currentSolIndex == 0) ? 0 : 1
        setCurrentSol()
    }

    @objc
    private func goToNextSol(_ sender: Any) {
        self.currentSolIndex += (currentSolIndex == photoController.sols.count - 1) ? 0 : 1
        setCurrentSol()
    }

    private func setCurrentSol() {
        if currentSolIndex < photoController.sols.count && currentSolIndex >= 0 {
            let sol = photoController.sols[currentSolIndex]
            currentSol = sol
            self.photoController.fetchPhotoReferences(for: sol) { photoRefs, error in
                if let error = error {
                    NSLog("Error fetching photoRefs: \(error)")
                    return
                }
                self.photoReferences = photoRefs ?? []
                DispatchQueue.main.async { self.updateViews() }
            }
        }
    }
}
