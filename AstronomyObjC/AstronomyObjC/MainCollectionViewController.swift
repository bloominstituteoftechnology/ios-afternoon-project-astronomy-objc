//
//  MainCollectionViewController.swift
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/22/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

class MainCollectionViewController : UICollectionViewController {
    
    // MARK:- Properties
    
    static let nsCache = NSCache<NSNumber,UIImage>()
    private let manifestFetcher = ManifestFetcher()
    private let photoFetcher = SolFetcher()

    var sols = [MarsSol]() {
        didSet {
            MainCollectionViewController.nsCache.removeAllObjects()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    private var count = 1
    private let photoFetchQueue = OperationQueue()
    private var operations = [Int:Operation]()
    
    
 
    private var solNumber = 0 {
        didSet {
            DispatchQueue.main.async {
                self.navigationItem.title = "Sol \(self.solNumber)"
            }
           
        }
    }
    
  //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        manifestFetcher.fetchManifest(forRover: "curiosity") { (manifest, _) in
            guard let manifest = manifest else { return }

            if let solNumber =  manifest.sols[self.count] as? Int {  self.solNumber = solNumber  }

            self.photoFetcher.fetchPhotos(forRover: "curiosity", withSol:NSNumber(value: self.solNumber)) { (sols, _) in
                if let sols = sols {

                        self.sols = sols
                        sols.forEach { (sol) in
                            DispatchQueue.global().async {
                                let image = UIImage(data: try! Data(contentsOf: (URL(string: sol.imageURL)?.usingHTTPS!)!))
                                MainCollectionViewController.self.nsCache.setObject(image!, forKey: sol.idNumber)
                            }
                        }

                    DispatchQueue.main.async {  self.collectionView.reloadData()   }

                }

            }
        }
      
    }

   //MARK:- Functions
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        count -= 1
    
        manifestFetcher.fetchManifest(forRover: "curiosity") { (manifest, _) in
            guard let manifest = manifest else { return }

            if let solNumber =  manifest.sols[self.count] as? Int {  self.solNumber = solNumber  }

            self.photoFetcher.fetchPhotos(forRover: "curiosity", withSol:NSNumber(value: self.solNumber)) { (sols, _) in
                if let sols = sols {

                        self.sols = sols
                        sols.forEach { (sol) in

                            DispatchQueue.global().async {
                                 let image = UIImage(data: try! Data(contentsOf: (URL(string: sol.imageURL)?.usingHTTPS!)!))
                                MainCollectionViewController.self.nsCache.setObject(image!, forKey: sol.idNumber)
                            }
                        }
                    DispatchQueue.main.async {  self.collectionView.reloadData()   }

                }

            }
        }
        
    }
  
    

    @IBAction func goForward(_ sender: UIBarButtonItem) {
         count += 1
        manifestFetcher.fetchManifest(forRover: "curiosity") { (manifest, _) in
            guard let manifest = manifest else { return }
            
            if let solNumber =  manifest.sols[self.count] as? Int {  self.solNumber = solNumber  }
            
            self.photoFetcher.fetchPhotos(forRover: "curiosity", withSol:NSNumber(value: self.solNumber)) { (sols, _) in
                if let sols = sols {
                  
                        self.sols = sols
                        sols.forEach { (sol) in

                            DispatchQueue.global().async {
                                   let image = UIImage(data: try! Data(contentsOf: (URL(string: sol.imageURL)?.usingHTTPS!)!))
                                MainCollectionViewController.self.nsCache.setObject(image!, forKey: sol.idNumber)
                            }

                        }
                    DispatchQueue.main.async {  self.collectionView.reloadData()  }
                
                }
                
            }
        }
    }
    //MARK:- CollectionView Datasource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
        return sols.count
    }
    private func loadImage(forCell cell: SolCollectionViewCell, forItemAt indexPath: IndexPath) {
        let sol = sols[indexPath.item]
      
        if let cachedImage = MainCollectionViewController.nsCache.object(forKey: sol.idNumber) {
            cell.soiImageView?.image = cachedImage
            return
        }
        
        let fetchOp = FetchPhotoOperation(photoReference: sol)
        let cacheOp = BlockOperation {
            if let image = fetchOp.image {
                MainCollectionViewController.nsCache.setObject(image, forKey: sol.idNumber)
            }
        }
        let completionOp = BlockOperation {
            defer { self.operations.removeValue(forKey: Int(truncating: sol.idNumber)) }
            
            if let currentIndexPath = self.collectionView.indexPath(for: cell),
                currentIndexPath != indexPath {
                return // Cell has been reused
            }
            if let image = fetchOp.image {
                cell.soiImageView?.image = image
            }
           
        
            
        }
         cacheOp.addDependency(fetchOp)
        completionOp.addDependency(fetchOp)
        
        photoFetchQueue.addOperation(fetchOp)
        photoFetchQueue.addOperation(cacheOp)
        OperationQueue.main.addOperation(completionOp)
        
        operations[Int(truncating: sol.idNumber)] = fetchOp
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
    
  
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SolCell", for: indexPath) as! SolCollectionViewCell

        loadImage(forCell: cell, forItemAt: indexPath)
        return cell
    
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sol = sols[indexPath.item]
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController
        self.navigationController?.pushViewController(detailVC!, animated: true)
        detailVC?.sol = sol
        
    }
    
}
