//
//  LSIErrors.m
//  Astronomy - ObjC
//
//  Created by James McDougall on 3/5/21.
//

#import "LSIErrors.h"

// TODO: The domain should be reverse DNS for your app or framework
// com.CompanyName.ProductOrFrameworkName to make it unique
NSString * const LSIErrorDomain = @"com.LambdaSchool.ProductNameHere";

NSError *errorWithMessage(NSString *message, NSInteger errorCode) {
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : message };
    NSError *error = [NSError errorWithDomain:LSIErrorDomain code:LSIAPIError userInfo:userInfo];
    return error;
}
