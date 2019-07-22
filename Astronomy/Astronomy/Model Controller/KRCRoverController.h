//
//  KRCRoverController.h
//  Astronomy
//
//  Created by Christopher Aronson on 7/22/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^KRCRoverCompletion)(NSDictionary * _Nullable, NSError * _Nullable);

@interface KRCRoverController : NSObject

@property (nonatomic, nonnull, copy, readonly) NSArray *sols;

- (NSArray * _Nonnull)sols;

- (void)fetchSolWithCompletion: (KRCRoverCompletion _Nonnull)completion;

- (void)parseSolJson:(NSDictionary * _Nonnull)json;
@end
