//
//  ViewController.m
//  Astronomy_ObjectiveC
//
//  Created by Kenny on 6/15/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import "ViewController.h"
#import "KMLRoverController.h"
#import "KMLManifest.h"
#import "KMLSol.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    KMLRoverController *roverController = [[KMLRoverController alloc] init];
    
    [roverController fetchSolsFromRoverWithName:@"Curiosity" completion:^(KMLManifest *manifest) {
        [roverController fetchPhotosWithRoverName:manifest.roverName OnSol:manifest.sols[1] completion:^(KMLSol *sol) {
            NSLog(@"%@", sol.photoURLs);
        }];
    }];
}


@end
