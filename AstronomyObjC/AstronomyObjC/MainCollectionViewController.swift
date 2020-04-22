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
    var sols = [MarsSol]()
    private var count = 1
 
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
    
  
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SolCell", for: indexPath) as! SolCollectionViewCell
        let sol = sols[indexPath.item]
        if let image = MainCollectionViewController.nsCache.object(forKey: sol.idNumber) {
            DispatchQueue.main.async {    cell.soiImageView?.image = image }
               
        } else {   cell.soiImageView?.load(url: (URL(string: sol.imageURL)?.usingHTTPS!)!)  }
              return cell
    
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sol = sols[indexPath.item]
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController
        self.navigationController?.pushViewController(detailVC!, animated: true)
        detailVC?.sol = sol
        
    }
    
}
