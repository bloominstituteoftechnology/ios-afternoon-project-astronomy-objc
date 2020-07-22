//
//  CAMMarsRoverClient.m
//  Astronomy
//
//  Created by Cody Morley on 7/20/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

#import "CAMMarsRoverClient.h"
#import "Astronomy-Swift.h"
#import "CAMMarsRover.h"
#import "CAMSolDescription.h"
#import "CAMCamera.h"
#import "CAMMarsRoverClient.h"

@interface CAMMarsRoverClient ()

@property (nonatomic, readonly) NSURL *baseURL;
@property (nonatomic, readonly) NSString *apiKey;

@end


@implementation CAMMarsRoverClient
//MARK: - Inits -
-(instancetype)init
{
    self = [super init];
    if (self) {
         _baseURL = [NSURL URLWithString: @"https://api.nasa.gov/mars-photos/api/v1"];
        _apiKey = @"4Ez8mdcVkQm1spq5kxs9JGO3bSoJDdSsBrXNy7f7";
    }
    return self;
}


//MARK: - Actions -
- (void)fetchMarsRoverNamed:(NSString *)name
                   session:(NSURLSession *)session
                completion:(roverCompletion)completion
{
    
}

- (void)fetchPhotosFromRover:(CAMMarsRover *)rover
                         sol:(int)sol
                     session:(NSURLSession *)session
                  completion:(photoCompletion)completion
{
    NSURL *url = [self urlForPhotosFromRoverName: rover.name
                                             sol: sol];
    [self fetchFromURL: url
               session: session
            completion: ^(NSDictionary <NSString * : <NSArray<*CAMMarsPhoto > *> * _Nullable, NSError _Nullable) {
        NSMutableArray *photos = dictionary[@""]
            
        }
    }];
    
    
    /*
     let url = self.url(forPhotosfromRover: rover.name, on: sol)
     fetch(from: url, using: session) { (dictionary: [String : [MarsPhotoReference]]?, error: Error?) in
         guard let photos = dictionary?["photos"] else {
             completion(nil, error)
             return
         }
         completion(photos, nil)
     }
     */
}


//MARK: - Methods -
- (void)fetchFromURL:(NSURL *)url
        session:(NSURLSession *)session
     completion:(fetchCompletion)fetchCompletion
{
    [[session dataTaskWithURL: url
           completionHandler:^(NSData * _Nullable data,
                               NSURLResponse * _Nullable response,
                               NSError * _Nullable error) {
        if (error) {
            fetchCompletion(NULL, error);
            NSLog(@"error fetching objects from server. %@ :: %@", error, error.localizedDescription);
            return;
        }
        
        if (!data) {
            fetchCompletion(nil, [NSError new]);
            NSLog(@"No data returned from fetch.");
            return;
        }
        
        if (data) {
            id returnedData = data;
            fetchCompletion(returnedData, nil);
            return;
        }
    }] resume];
}

- (NSURL *)urlForPhotosFromRoverName:(NSString *)name
                                 sol:(int)sol
{
    if (self.baseURL) {
        NSURL *url = self.baseURL;
        [[[url URLByAppendingPathComponent: @"rovers"] URLByAppendingPathComponent: name] URLByAppendingPathComponent:@"photos"];
        NSURLComponents *urlComponents = [[NSURLComponents alloc]initWithURL: url resolvingAgainstBaseURL: YES];
        NSURLQueryItem *atSol = [NSURLQueryItem queryItemWithName: @"sol" value: [NSString stringWithFormat: @"%d", sol]];
        NSURLQueryItem *apiKey = [NSURLQueryItem queryItemWithName: @"api_key" value: self.apiKey];
        urlComponents.queryItems = @[atSol, apiKey];
        return urlComponents.URL;
    } else {
        NSLog(@"No base URL to provide path components and query items.");
        return nil;
    }
}

- (NSURL *)urlForInfoFromRoverName:()name
{
    if (self.baseURL) {
        NSURL *url = self.baseURL;
        [[url URLByAppendingPathComponent: @"manifests"] URLByAppendingPathComponent: name];
        NSURLComponents *urlComponents = [[NSURLComponents alloc]initWithURL: url resolvingAgainstBaseURL: YES];
        NSURLQueryItem *apiKey = [NSURLQueryItem queryItemWithName: @"api_key" value: self.apiKey];
        urlComponents.queryItems = @[apiKey];
        return urlComponents.URL;
    } else {
        NSLog(@"No base URL to provide path components and query items.");
        return nil;
    }
}

@end

/*
import Foundation

class MarsRoverClient {
    
    func fetchMarsRover(named name: String,
                        using session: URLSession = URLSession.shared,
                        completion: @escaping (MarsRover?, Error?) -> Void) {
        
        let url = self.url(forInfoForRover: name)
        fetch(from: url, using: session) { (dictionary: [String : MarsRover]?, error: Error?) in
            guard let rover = dictionary?["photo_manifest"] else {
                completion(nil, error)
                return
            }
            completion(rover, nil)
        }
    }
    
    func fetchPhotos(from rover: MarsRover,
                     onSol sol: Int,
                     using session: URLSession = URLSession.shared,
                     completion: @escaping ([MarsPhotoReference]?, Error?) -> Void) {
        
        let url = self.url(forPhotosfromRover: rover.name, on: sol)
        fetch(from: url, using: session) { (dictionary: [String : [MarsPhotoReference]]?, error: Error?) in
            guard let photos = dictionary?["photos"] else {
                completion(nil, error)
                return
            }
            completion(photos, nil)
        }
    }
    
    // MARK: - Private
    
    private func fetch<T: Codable>(from url: URL,
                           using session: URLSession = URLSession.shared,
                           completion: @escaping (T?, Error?) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "com.LambdaSchool.Astronomy.ErrorDomain", code: -1, userInfo: nil))
                return
            }
            
            do {
                let jsonDecoder = MarsPhotoReference.jsonDecoder
                let decodedObject = try jsonDecoder.decode(T.self, from: data)
                completion(decodedObject, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    private let baseURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1")!
    private let apiKey = "qzGsj0zsKk6CA9JZP1UjAbpQHabBfaPg2M5dGMB7"

    private func url(forInfoForRover roverName: String) -> URL {
        var url = baseURL
        url.appendPathComponent("manifests")
        url.appendPathComponent(roverName)
        let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        return urlComponents.url!
    }
    
    private func url(forPhotosfromRover roverName: String, on sol: Int) -> URL {
        var url = baseURL
        url.appendPathComponent("rovers")
        url.appendPathComponent(roverName)
        url.appendPathComponent("photos")
        let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [URLQueryItem(name: "sol", value: String(sol)),
                                    URLQueryItem(name: "api_key", value: apiKey)]
        return urlComponents.url!
    }
}
*/
