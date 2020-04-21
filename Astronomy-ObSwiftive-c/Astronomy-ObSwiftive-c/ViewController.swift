//
//  ViewController.swift
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/16/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var photoController = PhotoController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        photoController.fetchPhotoManifest("curiosity") { (data, error) in
            return
        }
    }


}


/*
 1. Get the manifest for a specific rover:
 We will need to access the array for the photos key. In the array, we have dictionaries of type SolPhotos.
 
 api for manifest: https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=SfjvKWsq2nadyrPm5tfc2czHgHH8nyrttAXDqn3y
 {
 "photo_manifest": {
 "name": "Curiosity",
 "landing_date": "2012-08-06",
 "launch_date": "2011-11-26",
 "status": "active",
 "max_sol": 2736,
 "max_date": "2020-04-17",
 "total_photos": 416179,
 "photos": [
 {
 "sol": 0,
 "earth_date": "2012-08-06",
 "total_photos": 3702,
 "cameras": [
 "CHEMCAM",
 "FHAZ",
 "MARDI",
 "RHAZ"
 ]
 },
 {
 "sol": 1,
 "earth_date": "2012-08-07",
 "total_photos": 16,
 "cameras": [
 "MAHLI",
 "MAST",
 "NAVCAM"
 ]
 },v
 
 2. Ask for photos for a sol:
 We need to access the aray for the photos key. This should be dictionaries of type Photo.
 Navigate the sol in the manifest array and build a urlRequest for the photos of that sol in this array.
 
    Sol 12: https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=12&api_key=SfjvKWsq2nadyrPm5tfc2czHgHH8nyrttAXDqn3y
 {
 "photos": [
 {
 "id": 518386,
 "sol": 1147,
 "camera": {
 "id": 20,
 "name": "FHAZ",
 "rover_id": 5,
 "full_name": "Front Hazard Avoidance Camera"
 },
 "img_src": "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01147/opgs/edr/fcam/FLB_499317313EDR_F0500848FHAZ00323M_.JPG",
 "earth_date": "2015-10-28",
 "rover": {
 "id": 5,
 "name": "Curiosity",
 "landing_date": "2012-08-06",
 "launch_date": "2011-11-26",
 "status": "active",
 "max_sol": 2736,
 "max_date": "2020-04-17",
 "total_photos": 416179,
 "cameras": [
 {
 "name": "FHAZ",
 "full_name": "Front Hazard Avoidance Camera"
 },
 {
 "name": "NAVCAM",
 "full_name": "Navigation Camera"
 },
 {
 "name": "MAST",
 "full_name": "Mast Camera"
 },
 {
 "name": "CHEMCAM",
 "full_name": "Chemistry and Camera Complex"
 },
 {
 "name": "MAHLI",
 "full_name": "Mars Hand Lens Imager"
 },
 {
 "name": "MARDI",
 "full_name": "Mars Descent Imager"
 },
 {
 "name": "RHAZ",
 "full_name": "Rear Hazard Avoidance Camera"
 }
 ]
 }
 },
 {
 "id": 518387,
 "sol": 1147,
 "camera": {
 "id": 20,
 "name": "FHAZ",
 "rover_id": 5,
 "full_name": "Front Hazard Avoidance Camera"
 },
 "img_src": "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01147/opgs/edr/fcam/FRB_499317313EDR_F0500848FHAZ00323M_.JPG",
 "earth_date": "2015-10-28",
 "rover": {
 "id": 5,
 "name": "Curiosity",
 "landing_date": "2012-08-06",
 "launch_date": "2011-11-26",
 "status": "active",
 "max_sol": 2736,
 "max_date": "2020-04-17",
 "total_photos": 416179,
 "cameras": [
 {
 "name": "FHAZ",
 "full_name": "Front Hazard Avoidance Camera"
 },
 {
 "name": "NAVCAM",
 "full_name": "Navigation Camera"
 },
 {
 "name": "MAST",
 "full_name": "Mast Camera"
 },
 {
 "name": "CHEMCAM",
 "full_name": "Chemistry and Camera Complex"
 },
 {
 "name": "MAHLI",
 "full_name": "Mars Hand Lens Imager"
 },
 {
 "name": "MARDI",
 "full_name": "Mars Descent Imager"
 },
 {
 "name": "RHAZ",
 "full_name": "Rear Hazard Avoidance Camera"
 }
 ]
 }
 },
 
 3. Request individual photos
 
    Request a single photo and display it in a detailviewcontroller
 
 NOTES: cannot use decodable
        need to use NSJSONSerialization
 
 code snippet:
 Construct your photo URLs (this is a synchronous method so just use it for prototyping)
 NSURL *photoURL = // Use NSURLComponents to create photo URL from API data (Sol # + 1st photo)
 
 NSError *imageError = nil;
 NSData *imageData = [NSData dataWithContentsOfURL:photoURL options:0 error:&error);
 if (imageError) {
    NSLog(@"Error loading image: %@", imageError);
    return;
 }
 UIImage *image = [UIImage imageWithData:imageData];
 
 // TODO: Update the UI on the main thread
 imageView.image = image;
 */

