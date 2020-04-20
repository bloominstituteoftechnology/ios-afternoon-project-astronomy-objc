//
//  UFOCamera.h
//  Astronomy - ObjC
//
//  Created by Ufuk Türközü on 20.04.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UFOCamera : NSObject

@property int identifier;
@property NSString *name;
@property int roverId;
@property NSString *fullName;

- (instancetype) initWithIdentifier:(int) identifier
                               name:(NSString *)name
                            roverId:(int)roverId
                           fullName:(NSString *)fullName;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
