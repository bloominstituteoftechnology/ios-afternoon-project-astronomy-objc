//
//  TXCMarsPhoto.h
//  AstronomyObjc
//
//  Created by Thomas Cacciatore on 7/22/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TXCCamera;
@interface TXCMarsPhoto : NSObject

@property int identifier;
@property int sol;
@property TXCCamera *camera;
@property NSDate *earthDate;





@end


