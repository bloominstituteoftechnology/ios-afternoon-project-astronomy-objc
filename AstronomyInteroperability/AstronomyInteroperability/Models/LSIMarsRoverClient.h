//
//  LSIMarsRoverClient.h
//  AstronomyInteroperability
//
//  Created by Nonye on 7/20/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(MarsRover)
NS_ASSUME_NONNULL_BEGIN


@interface LSIMarsRoverClient : NSObject

@property (nonatomic, readonly) int roverID;
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly) NSString *launchDate;
@property (nonatomic, readonly) NSString *landingDate;
@property (nonatomic, readonly, copy) NSString *status;
@property (nonatomic, readonly) int maxSol;
@property (nonatomic, readonly) NSString *maxDate;
@property (nonatomic, readonly) int numberOfPhotos;
@property (nonatomic, readonly, nullable) NSArray *sols;

- (instancetype)initWithID:(int)roverID
                      name:(nonnull NSString *)name
                launchDate:(nonnull NSString *)launchDate
               landingDate:(nonnull NSString *)landingDate
                    status:(nonnull NSString *)status
                    maxSol:(int)maxSol
                   maxDate:(nonnull NSString *)maxDate
            numberOfPhotos:(int)numberOfPhotos
                      sols:(nullable NSArray *)sols;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
