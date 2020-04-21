//
//  RoverPhoto.h
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/20/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RoverPhoto : NSObject


@property (nonatomic, readonly) uint photoID;
@property (nonatomic, readonly) int sol;
@property (nonatomic, readonly) NSURL *photoURL;

- (instancetype)initWithPhotoID:(uint)photoID
                            sol:(int)sol
                       photoURL:(NSURL *)photoURL;

@end

NS_ASSUME_NONNULL_END
