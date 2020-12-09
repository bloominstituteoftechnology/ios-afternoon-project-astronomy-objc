//
//  Camera.m
//  Astronomy
//
//  Created by Cora Jacobson on 12/5/20.
//

#import "Camera.h"

@implementation Camera

- (nonnull instancetype)initWithIdentifier:(int)anIdentifier
                                      name:(NSString *)aName
                                   roverID:(int)aRover
                                  fullName:(NSString *)aFullName
{
    if (self = [super init]) {
        _identifier = anIdentifier;
        _name = aName.copy;
        _roverID = aRover;
        _fullName = aFullName.copy;
    }
    return self;
}

- (nullable instancetype)initWithDictionary:(NSDictionary *)aDictionary
{
    NSNumber *identifier = [aDictionary objectForKey:@"id"];
    if (![identifier isKindOfClass:NSNumber.class]) return nil;
    
    NSString *name = [aDictionary objectForKey:@"name"];
    if (![name isKindOfClass:NSString.class]) return nil;
    
    NSNumber *roverID = [aDictionary objectForKey:@"rover_id"];
    if (![roverID isKindOfClass:NSNumber.class]) return nil;
    
    NSString *fullName = [aDictionary objectForKey:@"full_name"];
    if (![fullName isKindOfClass:NSString.class]) return nil;
    
    return [self initWithIdentifier:identifier.intValue
                               name:name
                            roverID:roverID.intValue
                           fullName:fullName];
}

@end
