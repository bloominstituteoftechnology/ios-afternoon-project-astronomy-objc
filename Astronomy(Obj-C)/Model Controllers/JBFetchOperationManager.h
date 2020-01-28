//
//  JBFetchOperationManager.h
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-28.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JBSol;


@interface JBFetchOperationManager : NSObject

- (void)fetchPhotoForSol:(JBSol *_Nonnull)sol
              completion:(void(^_Nonnull)(UIImage * _Nullable,
                                          NSError * _Nullable))completion;

@end
