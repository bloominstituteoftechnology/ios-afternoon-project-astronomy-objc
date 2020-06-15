//
//  KMLManifest.m
//  Astronomy_ObjectiveC
//
//  Created by Mark Poggi on 6/15/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import "KMLManifest.h"

@implementation KMLManifest

- (instancetype)initWithRoverName: (NSString *)roverName photoId:(int)photoId sols:(NSArray *)sols {
    if (self = [super init]) {
        _roverName = roverName;
        _photoId = photoId;
        _sols = sols;
    }
    return self;

}

@end
