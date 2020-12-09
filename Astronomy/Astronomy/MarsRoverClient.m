//
//  MarsRoverClient.m
//  Astronomy
//
//  Created by Cora Jacobson on 12/9/20.
//

#import "MarsRoverClient.h"
#import "Astronomy-Swift.h"
#import "LSIErrors.h"
#import "SolDescription.h"
#import "MarsPhoto.h"
#import "Camera.h"

static NSString *const MarsBaseURLString = @"https://api.nasa.gov/mars-photos/api/v1";
static NSString *const APIKey = @"qzGsj0zsKk6CA9JZP1UjAbpQHabBfaPg2M5dGMB7";

@implementation MarsRoverClient

+ (void)fetchMarsRoverWithName:(NSString *_Nonnull)aName
             completionHandler:(nonnull RoverCompletionHandler)completionHandler
{
    if (!completionHandler) return;
    NSURL *url = [self urlForInfoWithRover:aName];
    [[NSURLSession.sharedSession dataTaskWithURL:url
                               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error fetching rover: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        
        NSError *jsonError;
        NSDictionary *manifestDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:&jsonError];
        if (!manifestDictionary || ![manifestDictionary isKindOfClass:NSDictionary.class]) {
            NSLog(@"Error decoding JSON: %@", jsonError);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, jsonError);
            });
            return;
        }
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObject:manifestDictionary forKey:@"photo_manifest"];

        NSArray *photoArray = [dictionary objectForKey:@"photos"];
        NSMutableArray<SolDescription *> *solDescriptions = [[NSMutableArray<SolDescription *> alloc] init];
        
        for (NSDictionary *item in photoArray) {
            SolDescription *solDescription = [[SolDescription alloc] initWithDictionary:item];
            [solDescriptions addObject:solDescription];
        }
        
        MarsRover *rover = [[MarsRover alloc] initWithName:dictionary[@"name"]
                                                launchDate:dictionary[@"launch_date"]
                                               landingDate:dictionary[@"landing_date"]
                                                    status:dictionary[@"status"]
                                                    maxSol:dictionary[@"max_sol"]
                                                   maxDate:dictionary[@"max_date"]
                                            numberOfPhotos:dictionary[@"total_photos"]
                                           solDescriptions:solDescriptions];
        if (!rover) {
            NSError *apiError = errorWithMessage(@"Invalid data", LSIAPIError);
            NSLog(@"Error decoding data: %@", apiError);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, apiError);
            });
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(rover, nil);
        });
    }] resume];
}

+ (void)fetchPhotosFromRover:(NSString *)aName
                         Sol:(int)onSol
           completionHandler:(PhotosCompletionHandler)completionHandler
{
    if (!completionHandler) return;
    NSURL *url = [self urlForPhotosFromRover:aName sol:onSol];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error fetching photos: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        
        NSError *jsonError;
        NSDictionary *photoDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:&jsonError];
        if (!photoDictionary || ![photoDictionary isKindOfClass:NSDictionary.class]) {
            NSLog(@"Error decoding JSON: %@", jsonError);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, jsonError);
            });
            return;
        }
        NSDictionary *dictionary = [NSDictionary dictionaryWithObject:photoDictionary forKey:@"photos"];
        
        NSArray *photoArray = [dictionary objectForKey:@"photos"];
        NSMutableArray<MarsPhoto *> *photos = [[NSMutableArray<MarsPhoto *> alloc] init];
        
        for (NSDictionary *item in photoArray) {
            MarsPhoto *photo = [[MarsPhoto alloc] initWithDictionary:item];
            [photos addObject:photo];
        }
        
        if (!photos) {
            NSError *apiError = errorWithMessage(@"Invalid data", LSIAPIError);
            NSLog(@"Error decoding data: %@", apiError);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, apiError);
            });
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(photos, nil);
        });
    }] resume];
}

+ (NSURL *)urlForInfoWithRover:(NSString *)roverName
{
    NSURL *baseURL = [NSURL URLWithString:MarsBaseURLString];
    [baseURL URLByAppendingPathComponent:@"manifests"];
    [baseURL URLByAppendingPathComponent:roverName];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"api_key"
                                                             value:APIKey]];
    return urlComponents.URL;
}

+ (NSURL *)urlForPhotosFromRover:(NSString *)roverName sol:(int)onSol
{
    NSURL *baseURL = [NSURL URLWithString:MarsBaseURLString];
    [baseURL URLByAppendingPathComponent:@"rovers"];
    [baseURL URLByAppendingPathComponent:roverName];
    [baseURL URLByAppendingPathComponent:@"photos"];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"sol"
                                                             value:[NSString stringWithFormat:@"%i", onSol]],
                                 [NSURLQueryItem queryItemWithName:@"api_key"
                                                             value:APIKey]];
    return urlComponents.URL;
}

@end
