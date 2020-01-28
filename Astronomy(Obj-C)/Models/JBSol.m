//
//  JBSol.m
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-27.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import "JBSol.h"
#import "JBPhotoController.h"
#import "JBPhotoReference.h"

static NSDateFormatter *_dateDecodingFormatter;

@interface JBSol()

@property (weak, nonatomic) JBPhotoController *photoController;
@property (nonatomic, nullable) NSArray<JBPhotoReference *> *mutablePhotoRefs;

+(NSDateFormatter *)dateDecodingFormatter;

@end


@implementation JBSol

- (instancetype)initWithIndex:(NSUInteger)solIndex
                    earthDate:(NSDate *)earthDate
         usingPhotoController:(JBPhotoController *)photoController
{
    self = [super init];
    if (self) {
        _marsSol = solIndex;
        _earthDate = earthDate;
        _photoController = photoController;
        _mutablePhotoRefs = nil;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
              usingPhotoController:(JBPhotoController *)photoController
{
    NSNumber *solIndexObject = dictionary[@"sol"];
    NSString *earthDateString = dictionary[@"earth_date"];
    NSDate *earthDate = [[JBSol dateDecodingFormatter] dateFromString:earthDateString];

    self = [[JBSol alloc] initWithIndex:solIndexObject.unsignedIntegerValue
                              earthDate:earthDate
                   usingPhotoController:photoController];
    return self;
}

- (void)getPhotoRefsWithCompletion:(void(^)(NSArray<JBPhotoReference *> *))completion {
    if (self.mutablePhotoRefs) {
        completion([self.mutablePhotoRefs copy]);
        return;
    }
    [self.photoController
      fetchPhotoReferencesForSol:self
      completion:^(NSArray<JBPhotoReference *> * _Nullable photoRefs,
                   NSError * _Nullable error)
    {
        if (error) {
            NSLog(@"Error fetching photo refs: %@", error);
            completion(@[]);
            return;
        }

        if (photoRefs) {
            self.mutablePhotoRefs = [photoRefs mutableCopy];
            completion(photoRefs);
        } else {
            NSLog(@"no photo refs");
            self.mutablePhotoRefs = [@[] mutableCopy];
            completion(@[]);
        }
    }];
}

+ (NSDateFormatter *)dateDecodingFormatter {
    if (_dateDecodingFormatter) {
        return _dateDecodingFormatter;
    } else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-DD"];
        return formatter;
    }
}

@end
