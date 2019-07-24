//
//  SolTableViewController.swift
//  astronomy-objc
//
//  Created by Hector Steven on 7/22/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class SolTableViewController: UITableViewController {
	let solController = SolController()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		solController.fetchSols { (error) in
			if let error = error {
				print("Error : \(error)")
			}
			
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
		
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return solController.sols().count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "SolCell", for: indexPath)
		
		guard let sol = solController.sols()[indexPath.row] as? Sol else { return  cell}
		
		cell.textLabel?.text =  "Sol: \(sol.sol)"
		cell.detailTextLabel?.text = "Date: \(sol.earthDate) \t Photos count: \(sol.totalPhotos)"
		
		return cell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "SolPhotosSegue" {
			
			
			guard let vc = segue.destination as? PhotosCollectionViewController,
					let indexPath = tableView.indexPathForSelectedRow,
					let sol = solController.sols()[indexPath.row] as? Sol else { return }
			
			vc.solNumber = Int(sol.sol)
			
			
		}
	}
	
}
