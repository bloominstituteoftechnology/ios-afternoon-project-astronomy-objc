//
//  ViewController.m
//  Astronomy_ObjectiveC
//
//  Created by Kenny on 6/15/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import "DetailViewController.h"
#import "KMLRoverController.h"
#import "KMLManifest.h"
#import "KMLSol.h"
#import "KMLFetchPhotoOperation.h"
#import "LSIFileHelper.h"
#import "Astronomy_ObjectiveC-Swift.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    KMLRoverController *roverController = [[KMLRoverController alloc] init];
    
    [roverController fetchSolsFromRoverWithName:@"Curiosity" completion:^(KMLManifest *manifest) {
        [roverController fetchPhotosWithRoverName:manifest.roverName OnSol:manifest.solIDs[1] completion:^(KMLSol *sol) {
            NSLog(@"%@", sol.photos);
            NSDictionary *photoDictionary = sol.photos[0];



            NSURL *photoURL = photoDictionary.allValues[0];

            NSURLSession *session = NSURLSession.sharedSession;
            KMLFetchPhotoOperation *operation = [[KMLFetchPhotoOperation alloc] initWithPhotoURL:photoURL.usingHTTPS session:session];
            [operation start];
        }];
    }];
}


@end
