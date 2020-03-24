//
//  MBMSolInfo.h
//  Astronomy-Objc
//
//  Created by Michael on 3/23/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBMSolInfo : NSObject

@property (nonatomic, readonly)int sol;
@property (nonatomic, readonly)int totalPhotos;
@property (nonatomic, readonly)NSArray<NSString *> *cameras;

-(instancetype)initWithSol:(int)sol
               totalPhotos:(int)totalPhotos
                   cameras:(NSArray<NSString *> *)cameras;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
