//
//  SKSPhotoReference.h
//  Astronomy-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKSPhotoReference : NSObject

@property (nonatomic) int solId;
@property (nonatomic) int sol;
@property (nonatomic, nonnull) NSDate *earthDate;
@property (nonatomic, nonnull) NSURL *imageURL;

- (instancetype _Nullable)initWithID:(int)solId
                                 sol:(int)sol
                           earthDate:(nonnull NSDate *)earthDate
                            imageURL:(nonnull NSURL *)imageURL;

- (instancetype _Nullable)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end

