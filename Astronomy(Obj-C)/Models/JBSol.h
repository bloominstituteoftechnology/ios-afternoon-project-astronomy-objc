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

@property (nonatomic, readonly) NSUInteger marsSol;
@property (nonatomic, readonly) NSDate *earthDate;

- (instancetype)initWithIndex:(NSUInteger)solIndex
                     earthDate:(NSDate *)earthDate
          usingPhotoController:(JBPhotoController *)photoController;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
               usingPhotoController:(JBPhotoController *)photoController;

- (void)getPhotoRefsWithCompletion:(void(^)(NSArray<JBPhotoReference *> *))completion;

@end

NS_ASSUME_NONNULL_END
