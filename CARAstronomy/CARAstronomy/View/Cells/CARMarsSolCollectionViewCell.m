//
//  CARMarsSolCollectionViewCell.m
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/25/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import "CARMarsSolCollectionViewCell.h"
#import "NSURL+NSURL_CARUsingHTTPS.h"
#import "CARFetchPhotoOperation.h"
#import "CARCache.h"

@interface CARMarsSolCollectionViewCell ()

@property (nonatomic, nonnull) CARCache *cache;
@property (nonatomic, nonnull) NSOperationQueue *photoFetchQueue;

// TODO: Check out NSOperation Queue and see if you can fix it.

@end

@implementation CARMarsSolCollectionViewCell

- (instancetype) init {
    self = [super init];
    if (self) {
        _cache = [[CARCache alloc] init];
    }
    return self;
}

- (void)configureCellWithSol:(CARMarsSol *)sol {
    UIImage *image = [self.cache itemForKey:sol.idNumber];
    if (image) {
        self.solImageView.image = image;
    } else {
        NSURL *url = [[NSURL URLWithString:sol.imageURL] urlUsingHTTPS];
        [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                return;
            }
            
            if (!data) {
                return;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.solImageView.image = [UIImage imageWithData:data];
                [self.cache cacheItem:image forKey:sol.idNumber];
            });
        }] resume];
    }
}
@end
