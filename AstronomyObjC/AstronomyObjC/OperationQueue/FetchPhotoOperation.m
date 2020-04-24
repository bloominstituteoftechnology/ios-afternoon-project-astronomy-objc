//
//  FetchPhotoOperation.m
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/23/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

#import "FetchPhotoOperation.h"
#import "AstronomyObjC-Swift.h"
#import "Sol.h"

@interface FetchPhotoOperation ()

@property (nonatomic, strong, readwrite, nullable) UIImage *image;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property BOOL internalIsExecuting;
@property BOOL internalIsFinished;


@end

@implementation FetchPhotoOperation {


    BOOL _isFinished;
    BOOL _isExecuting;
}
//MARK:- Properties 
- (BOOL)isAsynchronous { return YES; }
- (BOOL)isConcurrent { return YES; }
+ (NSSet *)keyPathsForValuesAffectingInternalIsExecuting { return [NSSet setWithObject:@"internalIsExecuting"] ;}
- (BOOL)isExecuting { return self.internalIsExecuting; }
+ (NSSet *)keyPathsForValuesAffectingInternalIsFinished {
    return [NSSet setWithObject:@"internalIsFinished"];
}
- (BOOL)isFinished { return self.internalIsFinished; }

- (instancetype)initWithPhotoReference:(Sol *)solReference {
    self = [super init];
    if (self) {
        _solReference = solReference;
    }
    return self;
}


- (void)start {
    self.internalIsExecuting = YES;
    NSURL * url = [NSURL URLWithString:self.solReference.imageURL].usingHTTPS;
   
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (self.isCancelled) {
            self.internalIsFinished = YES;
            self.internalIsExecuting = NO;
            return;
        }
        if (error) {
            NSLog(@"No data %@",error);
        }
        
        if (data) {
            self.image = [UIImage imageWithData:data];
        }
        self.internalIsExecuting = NO;
        self.internalIsFinished = YES;
        
    }];
    [task resume];
    self.dataTask = task;
    
}

-(void)cancel
{
    [self.dataTask cancel];
    [super cancel];
}














@end
