//
//  JBSol.h
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-27.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JBPhotoReference;
@class JBPhotoController;


NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Sol)
@interface JBSol : NSObject

@property (nonatomic, readonly) NSUInteger solIndex;
@property (nonatomic, readonly) NSDate *earthDate;
@property (nonatomic, readonly) NSArray<JBPhotoReference *> *photoReferences;

- (instancetype) initWithIndex:(NSUInteger)solIndex
                     earthDate:(NSDate *)earthDate
          usingPhotoController:(JBPhotoController *)photoController;
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
               usingPhotoController:(JBPhotoController *)photoController;

@end

NS_ASSUME_NONNULL_END
