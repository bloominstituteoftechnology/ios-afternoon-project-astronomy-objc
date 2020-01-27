//
//  JBPhotoCollectionViewCell.m
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-27.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import "JBPhotoCollectionViewCell.h"
#import "JBPhotoController.h"
#import "JBPhotoReference.h"


@implementation JBPhotoCollectionViewCell

- (void)setPhotoRef:(JBPhotoReference *)photoRef
{
    _photoRef = photoRef;
    if (photoRef && self.photoController) {
        [self fetchPhoto];
    }
}

- (void)fetchPhoto
{
    [self.photoController fetchPhotoForReference:self.photoRef
                                      completion:^(UIImage * _Nullable image,
                                                   NSError * _Nullable error)
    {
        if (error) {
            NSLog(@"Error fetching photo %lu: %@",
                  self.photoRef.photoID,
                  error);
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    }];
}

@end
