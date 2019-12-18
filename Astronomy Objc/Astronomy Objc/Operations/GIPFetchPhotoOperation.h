//
//  GIPFetchPhotoOperation.h
//  Astronomy Objc
//
//  Created by Gi Pyo Kim on 12/17/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

#import <Foundation/Foundation.h>"
@class MarsPhoto;

NS_SWIFT_NAME(FetchPhotoOperation)
@interface GIPFetchPhotoOperation : NSOperation

- (instancetype)initWithPhotoRef:(MarsPhoto *)photoRef;

@end

