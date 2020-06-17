//
//  ViewController.m
//  Astronomy_ObjectiveC
//
//  Created by Kenny on 6/15/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import "KMLDetailViewController.h"
#import "KMLRoverController.h"
#import "KMLManifest.h"
#import "KMLSol.h"
#import "KMLFetchPhotoOperation.h"
#import "LSIFileHelper.h"
#import "Astronomy_ObjectiveC-Swift.h"

@interface KMLDetailViewController ()

@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UILabel *roverName;
@property (weak, nonatomic) IBOutlet UILabel *cameraLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (nonatomic) NSArray<NSDictionary *> *operationQueue;

@end

@implementation KMLDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViews];
}

- (void)updateViews {
    KMLRoverController *roverController = [[KMLRoverController alloc] init];

    [roverController fetchSolsFromRoverWithName:@"Curiosity" completion:^(KMLManifest *manifest) {
        [roverController fetchPhotosWithRoverName:manifest.roverName OnSol:manifest.solIDs[1] completion:^(KMLSol *sol) {
            //            NSLog(@"%@", sol.photos);
            NSDictionary *photoDictionary = sol.photos[0];

            NSURL *photoURL = photoDictionary.allValues[0];

            NSURLSession *session = NSURLSession.sharedSession;

            KMLFetchPhotoOperation *operation = [[KMLFetchPhotoOperation alloc] initWithPhotoURL:photoURL.usingHTTPS session:session];
            NSBlockOperation *completionBlock = [NSBlockOperation blockOperationWithBlock:^{
                NSLog(@"done");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.photoImageView setImage:operation.image];
                });
            }];
            [completionBlock addDependency:operation];
            NSOperationQueue *operationQueue = [[NSOperationQueue alloc]init];
            [operationQueue addOperation:operation];
            [operationQueue addOperation:completionBlock];

        }];
    }];

}


@end
