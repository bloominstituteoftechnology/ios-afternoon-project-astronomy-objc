//
//  Camera.h
//  Astronomy
//
//  Created by Cora Jacobson on 12/5/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Camera : NSObject

@property (nonatomic, readonly) int identifier;
@property (nonatomic, copy, readonly, nonnull) NSString *name;
@property (nonatomic, readonly) int roverID;
@property (nonatomic, copy, readonly, nonnull) NSString *fullName;

- (nonnull instancetype)initWithIdentifier:(int)anIdentifier
                                      name:(NSString *)aName
                                   roverID:(int)aRover
                                  fullName:(NSString *)aFullName;

- (nullable instancetype)initWithDictionary:(NSDictionary *)aDictionary;

@end

NS_ASSUME_NONNULL_END
