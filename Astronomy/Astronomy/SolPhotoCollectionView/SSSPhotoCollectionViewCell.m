//
//  SSSPhotoCollectionViewCell.m
//  Astronomy
//
//  Created by Shawn Gee on 5/19/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "SSSPhotoCollectionViewCell.h"
#import "SSSMarsPhoto.h"
#import "SSSLoadImageOperation.h"

@interface SSSPhotoCollectionViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) SSSLoadImageOperation *loadImageOperation;

@end

@implementation SSSPhotoCollectionViewCell

@synthesize photo = _photo;

- (void)setPhoto:(SSSMarsPhoto *)photo {
    _photo = photo;
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:photo.imageURL resolvingAgainstBaseURL:YES];
    components.scheme = @"https";
    
    self.loadImageOperation = [[SSSLoadImageOperation alloc] initWithURL:components.URL imageView:self.imageView];
}

- (void)prepareForReuse {
    [self.loadImageOperation cancel];
    self.imageView.image = nil;
}

@end
