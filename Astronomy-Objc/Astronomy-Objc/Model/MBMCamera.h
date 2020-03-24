//
//  MBMCamera.h
//  Astronomy-Objc
//
//  Created by Michael on 3/23/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBMCamera : NSObject

@property (nonatomic, readonly)int identifier;
@property (nonatomic, readonly)NSString *name;
@property (nonatomic, readonly)int roverID;
@property (nonatomic, readonly)NSString *fullName;

-(instancetype)initWithIdentifier:(int)identifier
                             name:(NSString *)name
                          roverID:(int)roverID
                         fullName:(NSString *)fullName;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
