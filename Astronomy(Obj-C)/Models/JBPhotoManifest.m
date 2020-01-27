//
//  JBPhotoManifest.m
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-27.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import "JBPhotoManifest.h"
#import "JBSol.h"


@interface JBPhotoManifest()

@property (weak, nonatomic) JBPhotoController *photoController;

@end


@implementation JBPhotoManifest

- (instancetype)initWithName:(NSString *)roverName
                        sols:(NSArray<JBSol *> *)sols
             photoController:(JBPhotoController *)photoController
{
    self = [super init];
    if (self) {
        _roverName = roverName;
        _sols = sols;
        _photoController = photoController;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
                   photoController:(JBPhotoController *)photoController
{
    NSDictionary *manifestDict = dictionary[@"photo_manifest"];
    NSString *name = manifestDict[@"name"];
    NSArray *solRefs = manifestDict[@"photos"];

    NSMutableArray *sols = [@[] mutableCopy];
    for (NSDictionary *solRef in solRefs) {
        JBSol *sol = [[JBSol alloc] initWithDictionary:solRef
                                  usingPhotoController:self.photoController];
        [sols addObject:sol];
    }

    self = [[JBPhotoManifest alloc] initWithName:name
                                            sols:[sols copy]
                                 photoController:photoController];
    return self;
}

@end
