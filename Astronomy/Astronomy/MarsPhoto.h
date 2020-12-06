//
//  MarsPhoto.h
//  Astronomy
//
//  Created by Cora Jacobson on 12/5/20.
//

#import <Foundation/Foundation.h>

@class Camera;

NS_ASSUME_NONNULL_BEGIN

@interface MarsPhoto : NSObject

@property (nonatomic, readonly) int identifier;
@property (nonatomic, readonly) int sol;
@property (nonatomic, readonly, nonnull) Camera *camera;
@property (nonatomic, readonly, nonnull) NSDate *earthDate;
@property (nonatomic, readonly, copy, nonnull) NSURL *imageURL;

- (nonnull instancetype)initWithIdentifier:(int)anIdentifier
                                       sol:(int)aSol
                                    camera:(Camera *)aCamera
                                 earthDate:(NSDate *)aDate
                                  imageURL:(NSURL *)aURL;

- (nullable instancetype)initWithDictionary:(NSDictionary *)aDictionary;

@end

NS_ASSUME_NONNULL_END
