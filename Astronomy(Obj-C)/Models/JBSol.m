//
//  JBSol.m
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-27.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import "JBSol.h"
#import "JBPhotoController.h"
#import "JBPhotoReference.h"


@interface JBSol()

@property (nonatomic, nullable) NSMutableArray *internalPhotoRefs;
@property (weak, nonatomic) JBPhotoController *photoController;

@end


@implementation JBSol

- (instancetype)initWithIndex:(NSUInteger)solIndex
                    earthDate:(NSDate *)earthDate
         usingPhotoController:(JBPhotoController *)photoController
{
    self = [super init];
    if (self) {
        _solIndex = solIndex;
        _earthDate = earthDate;
        _photoController = photoController;
        _internalPhotoRefs = [@[] mutableCopy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
              usingPhotoController:(JBPhotoController *)photoController
{
    NSNumber *solIndexObject = dictionary[@"sol"];
    NSDate *earthDate = dictionary[@"earth_date"];

    self = [[JBSol alloc] initWithIndex:solIndexObject.unsignedIntegerValue
                              earthDate:earthDate
                   usingPhotoController:photoController];
    return self;
}

- (NSArray<JBPhotoReference *> *)photoReferences {
    return [self.internalPhotoRefs copy];
}

@end
