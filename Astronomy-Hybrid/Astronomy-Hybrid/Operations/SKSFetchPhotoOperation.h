//
//  SKSFetchPhotoOperation.h
//  Astronomy-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKSPhotoReference;

@interface SKSFetchPhotoOperation : NSOperation

@property (nonatomic, nullable) NSData *imageData;

-(instancetype _Nullable )initWithPhotoReference:(nonnull SKSPhotoReference *)photoReference;

@end

