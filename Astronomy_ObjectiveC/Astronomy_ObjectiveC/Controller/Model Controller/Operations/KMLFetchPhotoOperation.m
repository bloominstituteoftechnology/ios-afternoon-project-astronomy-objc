//
//  KMLFetchPhotoOperation.m
//  Astronomy_ObjectiveC
//
//  Created by Kenny on 6/16/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import "KMLFetchPhotoOperation.h"
@import UIKit;

@interface KMLFetchPhotoOperation ()

@property (nonatomic) UIImage *privateImage;
@property (nonatomic, readonly) NSURLSession *session;
@property (nonatomic, readonly) NSURLSessionDataTask *dataTask;

@end

@implementation KMLFetchPhotoOperation

- (instancetype)initWithPhotoURL:(NSURL *)photoURL session:(NSURLSession *)session
{
    self = [super init];
    if (self) {
        _session = session;
        _photoURL = photoURL;
    }
    return self;
}



- (void)start {
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:self.photoURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (self.isCancelled) {
            return;
        }

        if (error) {
            NSLog(@"Error fetching photo: %@", error);
            return;
        }

        if (!data) {
            NSLog(@"No data from photo operation");
            return;
        }

        UIImage *image = [UIImage imageWithData:data];
        [self setValue:image forKey:@"privateImage"];
        NSLog(@"%@", image);
    }];

    [dataTask resume];
    [self setValue:dataTask forKey:@"dataTask"];
}

- (void)cancel {
    [self.dataTask cancel];
    [super cancel];
}

- (UIImage *)image {
    return _privateImage;
}



@end
