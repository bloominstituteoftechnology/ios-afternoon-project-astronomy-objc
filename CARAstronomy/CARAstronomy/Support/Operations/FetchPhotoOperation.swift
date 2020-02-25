//
//  FetchPhotoOperation.swift
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/25/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

import Foundation

class FetchPhotoOperation: ConcurrentOperation {
    
    var sol: MarsSol
    var image: UIImage?
    
    init(sol: MarsSol) {
        self.sol = sol
    }
    
    override func start() {
        self.state = .isExecuting
        
        guard let url = URL(string: sol.imageURL)?.usingHTTPS else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.state = .isFinished }
            guard error == nil else { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            self.image = image
        }.resume()
    }
}
