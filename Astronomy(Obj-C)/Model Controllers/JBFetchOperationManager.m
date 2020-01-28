//
//  JBFetchOperationManager.m
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-28.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import "JBFetchOperationManager.h"
#import "JBSol.h"


@interface JBFetchOperationManager()

@property (nonatomic, nonnull) NSOperationQueue *fetchQueue;
@property (nonatomic, nonnull) NSDictionary<JBSol *, NSOperation *> *fetchOperations;

@end


@implementation JBFetchOperationManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _fetchQueue = [[NSOperationQueue alloc] init];
        _fetchOperations = [[NSDictionary alloc] init];
    }
    return self;
}

- (void)fetchPhotoForSol:(JBSol *)sol
              completion:(void (^)(UIImage * _Nullable,
                                   NSError * _Nullable))completion
{
    
}

@end
