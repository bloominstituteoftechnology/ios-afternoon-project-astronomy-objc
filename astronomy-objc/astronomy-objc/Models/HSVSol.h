//
//  HSVSol.h
//  astronomy-objc
//
//  Created by Hector Steven on 7/22/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(Sol)

@interface HSVSol : NSObject

@property (nonatomic, readonly) int sol;
@property (nonatomic, readonly) int totalPhotos;
@property (nonatomic, readonly, copy) NSString *earthDate;
@property (nonatomic, readonly, copy) NSArray<NSString *> *cameras;


-(instancetype)initWithSol:(int)sol totalPhotos:(int)totalPhotos earthDate:(NSString *)earthDate cameras:(NSArray *)cameras;

@end

NS_ASSUME_NONNULL_END
