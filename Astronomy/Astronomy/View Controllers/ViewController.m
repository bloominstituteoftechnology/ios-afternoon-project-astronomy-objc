//
//  ViewController.m
//  Astronomy
//
//  Created by Christopher Aronson on 7/22/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

#import "ViewController.h"
#import "KRCNetwork.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KRCNetwork *call = [[KRCNetwork alloc] init];
    NSURL *url = [NSURL URLWithString:@"https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=bnqLeQQBboxLPczeBIjFzWTTYaNlGdCnVtJlGaJZ"];
    
    [call NetworkCallForURL:url completion:^(NSDictionary * _Nullable json, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSLog(@"%@", json);
        }
    }];
}


@end
