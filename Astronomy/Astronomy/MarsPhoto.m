//
//  MarsPhoto.m
//  Astronomy
//
//  Created by Cora Jacobson on 12/5/20.
//

#import "MarsPhoto.h"
#import "Camera.h"

@implementation MarsPhoto

- (nonnull instancetype)initWithIdentifier:(int)anIdentifier
                                       sol:(int)aSol
                                    camera:(Camera *)aCamera
                                 earthDate:(NSDate *)aDate
                                  imageURL:(NSURL *)aURL
{
    if (self = [super init]) {
        _identifier = anIdentifier;
        _sol = aSol;
        _camera = aCamera;
        _earthDate = aDate;
        _imageURL = aURL;
    }
    return self;
}

- (nullable instancetype)initWithDictionary:(NSDictionary *)aDictionary
{
    NSNumber *identifier = [aDictionary objectForKey:@"id"];
    if (![identifier isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *sol = [aDictionary objectForKey:@"sol"];
    if (![sol isKindOfClass:NSNumber.class]) return nil;
    
    NSDictionary *cameraDict = [aDictionary objectForKey:@"camera"];
    if (![cameraDict isKindOfClass:NSDictionary.class]) return nil;
    Camera *camera = [[Camera alloc] initWithDictionary:cameraDict];
    if (![camera isKindOfClass:Camera.class]) return nil;
    
    NSString *dateString = [aDictionary objectForKey:@"earth_date"];
    if (![dateString isKindOfClass:NSString.class]) return nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [[NSDate alloc] init];
    date = [formatter dateFromString:dateString];
    
    NSString *urlString = [aDictionary objectForKey:@"img_src"];
    if (![urlString isKindOfClass:NSString.class]) return nil;
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    if (![url isKindOfClass:NSURL.class]) return nil;
    
    return [self initWithIdentifier:identifier.intValue
                                sol:sol.intValue
                             camera:camera
                          earthDate:date
                           imageURL:url];
}

@end
