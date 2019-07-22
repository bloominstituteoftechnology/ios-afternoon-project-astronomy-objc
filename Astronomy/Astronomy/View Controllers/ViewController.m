//
//  ViewController.m
//  Astronomy
//
//  Created by Christopher Aronson on 7/22/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

#import "ViewController.h"
#import "KRCRoverController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KRCRoverController *roverController = [[KRCRoverController alloc] init];
    
    [roverController fetchSolWithCompletion:^(NSDictionary * _Nullable json, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error!!!!!!");
        } else {
            NSLog(@"SOL Fetch Complete");
        }
        
    }];
}


@end
