//
//  CARMarsSolCollectionViewCell.m
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/25/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import "CARMarsSolCollectionViewCell.h"
#import "NSURL+NSURL_CARUsingHTTPS.h"
#import "CARCache.h"

@interface CARMarsSolCollectionViewCell ()

@property (nonatomic, nonnull) CARCache *cache;
@property (nonatomic, nonnull) NSOperationQueue *photoFetchQueue;

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
        self.photoFetchQueue = [[NSOperationQueue alloc] init];
        self.photoFetchOperation = [[CARFetchPhotoOperation alloc] initWithSol:sol];
        NSBlockOperation *completionOperation = [NSBlockOperation blockOperationWithBlock:^{
            UIImage *image = self.photoFetchOperation.image;
            self.solImageView.image = image;
            [self.cache cacheItem:image forKey:sol.idNumber];
        }];
        
        [completionOperation addDependency:self.photoFetchOperation];
        [self.photoFetchQueue addOperation:self.photoFetchOperation];
        [NSOperationQueue.mainQueue addOperation:completionOperation];
    }
}
@end
