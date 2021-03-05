//
//  LSINetworkController.m
//  Astronomy - ObjC
//
//  Created by James McDougall on 3/5/21.
//

#import "LSINetworkController.h"

@implementation LSINetworkController

- (instancetype)init
{
    if (self = [super init]) {
        _baseURL = @"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=107OBMENnXWNvlJ1aacutLCYdyaWNXGPT0encQ1J";
    }
    return self;
}

- (void)fetchSolTenImage:(ImageURLFetcherCompletionHandler)completionHandler {
    NSURL *url = [[NSURL alloc] initWithString: self.baseURL];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
        if (error) {
            LSILog(@"ERROR: Could not complete photo data task, reason: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        if (!data) {
            LSILog(@"ERROR: Data could not be retreived, reason: %@",error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        
        NSError *jsonError;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"ERROR: Could not convert JSON into dectionary! %@", jsonError);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        
        NSArray *array = dictionary[@"photos"];
        NSDictionary *firstPhoto = array[0];
        NSString *imageURLString = firstPhoto[@"img_src"];
        NSURL *imageURL = [[NSURL alloc] initWithString:imageURLString];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(imageURL, nil);
        });
        
        }]resume];
}

- (void)fetchPhotoWithURL:(NSURL *)url completionHandler:(ImageFetcherCompletionHandler)completionHandler {
    
    NSURLComponents *secureURLComponents = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:true];
    secureURLComponents.scheme = @"https";
    NSURL *secureURL = secureURLComponents.URL;
    
    [[NSURLSession.sharedSession dataTaskWithURL:secureURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
        if (error) {
            LSILog(@"ERROR: Error occured when fetching the image, reason: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        if (!data) {
            LSILog(@"ERROR: Data could not be retreived, reason: %@",error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        
        UIImage *requestedImage = [[UIImage alloc] initWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(requestedImage, nil);
        });
        }]resume];
    
}

@end
