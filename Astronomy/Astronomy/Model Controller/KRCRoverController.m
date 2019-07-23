//
//  KRCRoverController.m
//  Astronomy
//
//  Created by Christopher Aronson on 7/22/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

#import "KRCRoverController.h"
#import "KRCNetwork.h"
#import "KRCSOL.h"
#import "KRCPhotoInfo.h"

@interface KRCRoverController ()

@property NSMutableArray *internalSols;
@property NSMutableArray *internalPhotoURLs;
@property (nonatomic, nonnull) KRCNetwork *networkController;

@property (nonnull) NSURL *solURL;
@property (nonnull) NSURL * baseURL;
@property (nonnull) NSString *api;
@end

@implementation KRCRoverController

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        _networkController = [[KRCNetwork alloc] init];
        
        _solURL = [NSURL URLWithString:@"https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=bnqLeQQBboxLPczeBIjFzWTTYaNlGdCnVtJlGaJZ"];
        _api = @"bnqLeQQBboxLPczeBIjFzWTTYaNlGdCnVtJlGaJZ";
        _baseURL = [NSURL URLWithString:@"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos"];
        
        _internalSols = [[NSMutableArray alloc] init];
        _internalPhotoURLs = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSArray *)sols {
    return _internalSols;
}

- (NSArray *)photoURLs {
    return [[self internalPhotoURLs] copy];
}

- (void)fetchSolWithCompletion: (KRCRoverCompletion _Nonnull)completion {
    NSLog(@"In fetchSolWithCompletion");
    
    [[self networkController] networkCallForURL:[self solURL] completion:^(NSDictionary * _Nullable json, NSError * _Nullable error) {
        
        if (error) {
            completion(error);
            return;
        }
        
        [self parseSolJson:json];
        
        completion(nil);
        
    }];
}

- (void)fetchPhotosFromSol:(NSNumber * _Nonnull)sol completion:(KRCRoverCompletion _Nonnull)completion {
    NSLog(@"In fetchPhotoFromSol");
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[self baseURL] resolvingAgainstBaseURL:NO];
    NSArray *queryItems = @[[NSURLQueryItem queryItemWithName:@"sol" value:[NSString stringWithFormat:@"%@", sol]],
                            [NSURLQueryItem queryItemWithName:@"api_key" value:[self api]]];
    
    [components setQueryItems:queryItems];
    NSURL *url = [components URL];
    
    [[self networkController] networkCallForURL:url completion:^(NSDictionary * _Nullable json, NSError * _Nullable error) {
        
        if (error) {
            completion(error);
            return;
        }
        
        [self parsePhotoJson:json];
        
        completion(nil);
    }];
    
}

- (void)parseSolJson:(NSDictionary * _Nonnull)json {
    NSLog(@"In parseSolJson");
    
    NSDictionary *manifest = [json objectForKey:@"photo_manifest"];
    NSArray *photos = [manifest objectForKey:@"photos"];
    
    for (int i = 0; i < photos.count; i++) {
        NSDictionary *solDictionary = [photos objectAtIndex:i];
        
        NSNumber *solNumber = [solDictionary objectForKey:@"sol"];
        KRCSOL *sol = [[KRCSOL alloc] initWithSol:solNumber];
        [[self internalSols] addObject:sol];
    }
}

- (void)parsePhotoJson:(NSDictionary *)json {
    NSLog(@"In parsePhotoJson");
    
    NSArray *photos = [json objectForKey:@"photos"];

    for (int i = 0; i < photos.count; i++) {
        
        NSDictionary *photosDictionary = [photos objectAtIndex:i];
        NSURL *photoURL = [photosDictionary objectForKey:@"img_src"];
        
        KRCPhotoInfo *photoInfo = [[KRCPhotoInfo alloc] initWithURL:photoURL];
        [[self internalPhotoURLs] addObject:photoInfo];
    }
}

@end
