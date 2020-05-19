//
//  SSSPhotoCollectionViewCell.m
//  Astronomy
//
//  Created by Shawn Gee on 5/19/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "SSSPhotoCollectionViewCell.h"
#import "SSSMarsPhoto.h"

@interface SSSPhotoCollectionViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SSSPhotoCollectionViewCell

@synthesize photo = _photo;

- (void)setPhoto:(SSSMarsPhoto *)photo {
    _photo = photo;
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:photo.imageURL resolvingAgainstBaseURL:YES];
    components.scheme = @"https";
    
    // TODO: Implement NSOperation for image fetching
    NSData *imageData = [NSData dataWithContentsOfURL:components.URL];
    self.imageView.image = [UIImage imageWithData:imageData];
}

@end
