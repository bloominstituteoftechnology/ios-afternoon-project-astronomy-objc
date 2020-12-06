//
//  SolDescription.h
//  Astronomy
//
//  Created by Cora Jacobson on 12/5/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SolDescription : NSObject

@property (nonatomic, readonly) int sol;
@property (nonatomic, readonly) int totalPhotos;
@property (nonatomic, copy, readonly, nonnull) NSArray<NSString *> *cameras;

- (nonnull instancetype)initWithSol:(int)aSol totalPhotos:(int)aTotal cameras:(NSArray<NSString *> *)someCameras;

- (nullable instancetype)initWithDictionary:(NSDictionary *)aDictionary;

@end

NS_ASSUME_NONNULL_END
