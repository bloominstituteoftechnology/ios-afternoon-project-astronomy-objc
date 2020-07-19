//
//  KRCPhotoInfo.m
//  Astronomy
//
//  Created by Christopher Aronson on 7/23/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

#import "KRCPhotoInfo.h"

@implementation KRCPhotoInfo

- (instancetype)initWithURL:(NSString *)url {
    
    self = [super init];
    
    if (self) {
        _photoURL = url;
    }
    
    return self;
}
@end
