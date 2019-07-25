//
//  HSVSolPhotDescription.h
//  astronomy-objc
//
//  Created by Hector Steven on 7/24/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(SolPhotoDescription)
NS_ASSUME_NONNULL_BEGIN

@interface HSVSolPhotDescription : NSObject


@property (nonatomic, readonly, copy) NSString *sol;
@property (nonatomic, readonly, copy) NSString *img_src;
@property (nonatomic, readonly, copy) NSString *earthDate;
@property (nonatomic, readonly, copy) NSString *cameraName;
@property (nonatomic, readonly, copy) NSString *rovername;


- (instancetype) initWithSol:(NSString *)sol img_src:(NSString *)img_src earthDate:(NSString *)earthDate cameraName:(NSString *)cameraName roverName:(NSString *)roverName;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;



@end

NS_ASSUME_NONNULL_END
