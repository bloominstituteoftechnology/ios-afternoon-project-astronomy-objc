//
//  LYDSol.h
//  LYDAstronomyObjC
//
//  Created by Lydia Zhang on 5/18/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYDSol : NSObject

@property int sol;
@property int totalPhotos;
@property NSArray<NSString *> *cameraArray;


- (instancetype)initWithSolDictionary: (NSDictionary *)solDictionary;

@end

NS_ASSUME_NONNULL_END
