//
//  ViewController.m
//  Astronomy-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

/*
    https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=DEMO_KEY
    https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=DEMO_KEY
     Structure:
        CollectionView: Swift
        DetailView: Swift
        One Model: Swift (Or use Objc for all)
        Cache (Objc)
        ModelController: Objc
     1. Try to download the JSON for the manifest
         2. Try to download the JSON for a given sol (#1, #10, #92 other)
     3. Refactor code into a model controller
     4. Building model objects to pull out information

    NSURL *url = [NSURL URLWithString:@"https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=DEMO_KEY"];
    // NSURLSession dataTask

*/

    NSURL *maifestURL = [NSURL URLWithString:@"https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=DEMO_KEY"];
    NSURL *sol10URL = [NSURL URLWithString:@"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=DEMO_KEY"];

    [[[NSURLSession sharedSession] dataTaskWithURL:maifestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error) {

        }

        NSError *jsonError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

        if (jsonError) {

        }



        if (![dictionary isKindOfClass:[NSDictionary class]]) {
            NSError *dictionaryError = (NSError *)dictionary;
            NSLog(@"It is not of dictionary type %@", [dictionaryError localizedDescription]);
        }

        NSDictionary *photoManifest = dictionary[@"photo_manifest"];
        NSString *name = photoManifest[@"name"];
        NSLog(@"Name: %@", name);

        NSArray *photoDictionaries = photoManifest[@"photos"];
        NSLog(@"Number of photos: %lu", photoDictionaries.count);



    }] resume];


    // SOL 10
    [[[NSURLSession sharedSession] dataTaskWithURL:sol10URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error) {

        }

        NSError *jsonError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

        if (jsonError) {

        }



        if (![dictionary isKindOfClass:[NSDictionary class]]) {
            NSError *dictionaryError = (NSError *)dictionary;
            NSLog(@"It is not of dictionary type %@", [dictionaryError localizedDescription]);
        }

        NSArray *photos = dictionary[@"photos"];
        NSLog(@"Sol 10 Number of photos: %lu", photos.count);



    }] resume];


}


@end
