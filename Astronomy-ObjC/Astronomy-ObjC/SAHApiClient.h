//
//  SAHApiClient.h
//  Astronomy-ObjC
//
//  Created by scott harris on 4/20/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SAHNasaManifest;

typedef void (^SAHManifestFetcherCompletionBlock)(SAHNasaManifest * manifest, NSError *error);

@interface SAHApiClient : NSObject

-(void)fetchManifestWithCompletionBlock:(SAHManifestFetcherCompletionBlock)completionBlock;

@end
