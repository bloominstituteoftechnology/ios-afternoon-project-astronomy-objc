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

@interface KRCRoverController ()

@property NSMutableArray *internalSols;
@property (nonatomic, nonnull) KRCNetwork *networkController;

@property NSURL * _Nonnull solURL;
@end

@implementation KRCRoverController



- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        _networkController = [[KRCNetwork alloc] init];
        _solURL = [NSURL URLWithString:@"https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=bnqLeQQBboxLPczeBIjFzWTTYaNlGdCnVtJlGaJZ"];
    }
    
    return self;
}

- (NSArray *)sols {
    return _internalSols;
}

- (void)fetchSolWithCompletion: (KRCRoverCompletion _Nonnull)completion {
    
    [[self networkController] networkCallForURL:[self solURL] completion:^(NSDictionary * _Nullable json, NSError * _Nullable error) {
        
        if (error) {
            completion(nil, error);
            return;
        }
        
        
        
        completion(json, nil);
        
    }];
}

- (void)parseSolJson:(NSDictionary * _Nonnull)json {
    
    
}

@end
