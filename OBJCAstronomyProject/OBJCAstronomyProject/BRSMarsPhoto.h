//
//  BRSMarsPhoto.h
//  OBJCAstronomyProject
//
//  Created by BrysonSaclausa on 12/4/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BRSCamera;

@interface BRSMarsPhoto : NSObject

@property (nonatomic, readonly) NSInteger *identifier;
@property (nonatomic, readonly) NSInteger *sol;
@property (nonatomic, strong) BRSCamera *camera;
@property (nonatomic) NSDate *earthDate;
@property (nonatomic) NSURL *imageURL;

@end

NS_ASSUME_NONNULL_END
