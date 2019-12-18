//
//  LSIPhotoDetailViewController.m
//  Astronomy-Hybrid
//
//  Created by Isaac Lyons on 12/17/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

#import "LSIPhotoDetailViewController.h"
#import "Astronomy_Hybrid-Swift.h"

@interface LSIPhotoDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *photoIdTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *earthDateTextLabel;

@end

@implementation LSIPhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViews];
}

- (void)updateViews {
    [self.imageView setImage:self.image];
    [self.photoIdTextLabel setText:[NSString stringWithFormat:@"Photo ID: %ld", (long)[self.photoReference id]]];
    [self.earthDateTextLabel setText:[NSString stringWithFormat:@"Earth date: %@", [self.photoReference dateString]]];
}

@end
