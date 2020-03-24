//
//  APIController.m
//  AstronomyMix
//
//  Created by Jorge Alvarez on 3/23/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

#import "APIController.h"

#import "AstronomyMix-Swift.h"

@interface APIController()

@property (nonatomic) NSMutableArray *internalSolPhotos;

@end

@implementation APIController

/// Default Init
- (instancetype)init {
    self = [super init];
    if (self) {
        // TODO: Remove later (for testing only)
        [self addTestPhotos];
        NSLog(@"%lu", (unsigned long)self.internalSolPhotos.count);
    }
    return self;
}

/// Computed property for solPhotos array
- (NSArray *)solPhotos {
    return [self.internalSolPhotos copy];
}

/// Lazy init for internalSolPhotos
- (NSMutableArray *)internalContacts {
    if (!_internalSolPhotos) {
        _internalSolPhotos = [[NSMutableArray alloc] init];
    }
    return _internalSolPhotos;
}

/// Mock Data
- (void)addTestPhotos {
    NSLog(@"called add test photos");
    [self.internalSolPhotos addObjectsFromArray:@[
        [[Rover alloc] initWithName:@"Bill" photos:@"test.jpg"],
        [[Rover alloc] initWithName:@"Bob" photos:@"test.jpg"],
        [[Rover alloc] initWithName:@"John" photos:@"test.jpg"]
    ]];
}

@end
