//
//  CMBMarsController.m
//  Astronomy
//
//  Created by Craig Belinfante on 12/6/20.
//

#import "CMBMarsController.h"
#import "CMBMarsSolDictionary.h"
#import "CMBMarsSol.h"
#import "CMBMarsObject.h"
#import "LSIErrors.h"

static NSString *baseUrlString = @"https://api.nasa.gov/mars-photos/api/v1/";
static NSString *apiKey = @"03IKcWivg4aycoe4mmfqcsR6XY3HfFgDy6gnwbEx";

@implementation CMBMarsController

- (void)fetchDetailsForRoverNamed:(NSString *)roverName
                                      completion:(FetchSolCompletion)completion {
    NSURL *url = [[NSURL URLWithString:baseUrlString] URLByAppendingPathComponent:@"manifests"];
    url = [url URLByAppendingPathComponent:roverName];
    
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey],
    ];
    url = urlComponents.URL;
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

           if (error) {
               completion(nil, error);
               return;
           }

           if (!data) {
               NSError *dataError = errorWithMessage(@"No mars data found", LSIDataNilError);
               completion(nil, dataError);
               return;
           }

           NSError *jsonError = nil;
           NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

           if (jsonError) {
               completion(nil, jsonError);
               return;
           }
           
           NSDictionary *solPhotos = dictionary[@"photo_manifest"];
           CMBMarsSolDictionary *solDictionary = [[CMBMarsSolDictionary alloc] initWithDictionary:solPhotos];
           completion(solDictionary, nil);
       }];
       
       [task resume];
   }

//- (void)fetchPhotosForRoverNamed:(NSString *)roverName

@end
