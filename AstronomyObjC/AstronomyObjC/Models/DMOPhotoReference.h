//
//  DMOPhotoReference.h
//  AstronomyObjC
//
//  Created by morse on 1/26/20.
//  Copyright © 2020 morse. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_SWIFT_NAME(PhotoReference)
@interface DMOPhotoReference : NSObject

@property (nonatomic) int id;
@property (nonatomic) NSURL *imageURL;

- (instancetype)initWithID:(int)id imageURL:(NSURL *)imageURL;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
