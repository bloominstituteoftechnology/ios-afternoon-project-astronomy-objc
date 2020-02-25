//
//  CARMarsSolCollectionViewCell.m
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/25/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import "CARMarsSolCollectionViewCell.h"

@interface CARMarsSolCollectionViewCell ()

@property (nonatomic, nullable) UIActivityIndicatorView *activityIndicator;

@end

@implementation CARMarsSolCollectionViewCell

- (void)configureCellWithImageURL:(NSURL *)url {
    [self loadImageForURL:url];
}

- (void)loadImageForURL:(NSURL *)url {
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            return;
        }
        
        if (!data) {
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.solImageView.image = [UIImage imageWithData:data];
        });
    }] resume];
}
@end
