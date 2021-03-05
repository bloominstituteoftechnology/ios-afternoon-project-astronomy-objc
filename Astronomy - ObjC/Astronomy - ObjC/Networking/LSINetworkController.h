//
//  LSINetworkController.h
//  Astronomy - ObjC
//
//  Created by James McDougall on 3/5/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LSILog.h"
#import "LSIErrors.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ImageURLFetcherCompletionHandler)(NSURL *_Nullable photo, NSError *_Nullable error);
typedef void(^ImageFetcherCompletionHandler)(UIImage *_Nullable image, NSError *_Nullable error);

@interface LSINetworkController : NSObject

/// - Properties
@property (nonatomic, nonnull) NSString *baseURL;

/// - Methods
- (void)fetchSolTenImage:(ImageURLFetcherCompletionHandler)completionHandler;
- (void)fetchPhotoWithURL:(NSURL *)url completionHandler:(ImageFetcherCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
