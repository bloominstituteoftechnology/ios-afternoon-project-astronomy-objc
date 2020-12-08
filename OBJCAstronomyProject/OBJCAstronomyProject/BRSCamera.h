//
//  BRSCamera.h
//  OBJCAstronomyProject
//
//  Created by BrysonSaclausa on 12/4/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRSCamera : NSObject

@property (nonatomic, readonly) NSInteger *identifier;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSInteger *roverId;
@property (nonatomic, readonly) NSString *fullName;

@end

NS_ASSUME_NONNULL_END
