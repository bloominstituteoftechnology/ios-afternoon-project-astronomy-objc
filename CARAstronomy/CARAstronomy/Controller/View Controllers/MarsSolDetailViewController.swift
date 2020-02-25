//
//  MarsSolDetailViewController.swift
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/25/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

import Foundation

class MarsSolDetailViewController: UIViewController {
    
    @IBOutlet weak var solImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    
    var photoQueue = OperationQueue()
    var sol: CARMarsSol? {
        didSet {
            updateViews()
        }
    }
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        guard let sol = sol, self.isViewLoaded else { return }
        descriptionLabel.text = "Taken by \(sol.idNumber) on \(dateFormatter.string(from: sol.earthDate)) (Sol \(sol.sol))"
        title = sol.camera.name
        cameraLabel.text = sol.camera.fullName
        fetchImage(for: sol)
    }
    
    private func fetchImage(for sol: CARMarsSol) {
        let photoFetchOperation = FetchPhotoOperation(sol: sol)
        let completionOperation = BlockOperation {
            guard let image = photoFetchOperation.image else { return }
            self.solImageView.image = image
        }
        
        completionOperation.addDependency(photoFetchOperation)
        photoQueue.addOperation(photoFetchOperation)
        OperationQueue.main.addOperation(completionOperation)
    }
}
