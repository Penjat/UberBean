//
//  NetworkManager.m
//  UberBean
//
//  Created by Spencer Symington on 2019-01-26.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager
+ (instancetype)sharedInstance{
    static NetworkManager *networkManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkManager = [[NetworkManager alloc] init];
        
    });
    return networkManager;
}
-(void)getYelpDataWithLatitude:(float)latitude longitude:(float)longitude{
    NSLog(@"getting the yelp data");
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc]init];
    
    [urlRequest addValue:@"Bearer sNLOf-pW5pM381GYYBVWmRmN1p0iGqJA9Nrsz4vJF0_qB5FLIFZtSXnQZbmDDnIJTkTtxqpJdz8Bup6KXuctGcGdfukRq5MIBFeoQh2lERc9Zjgz_WyOP-Xz_YBMXHYx" forHTTPHeaderField:@"Authorization"];
    NSString *urlString = [NSString stringWithFormat:@"https://api.yelp.com/v3/businesses/search?term=cafe&latitude=%f&longitude=%f" ,latitude,longitude ];
    NSURL *url = [NSURL URLWithString:urlString];
    [urlRequest setURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 3
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *allData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]; // 2
        
        if (jsonError) { // 3
            // Handle the error
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        
        //create 1 url
        NSArray *businessArray =  allData[@"businesses"];
        
       
        
        
        
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //UPDATES for UI in here
            [self.delegate recieveData:businessArray]; 
        }];
    }];
    
    [dataTask resume];
}

-(void)getYelpReviews:(NSString*)cafeId{
    
    
    NSLog(@"getting the yelp reviews");
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc]init];
    
    [urlRequest addValue:@"Bearer sNLOf-pW5pM381GYYBVWmRmN1p0iGqJA9Nrsz4vJF0_qB5FLIFZtSXnQZbmDDnIJTkTtxqpJdz8Bup6KXuctGcGdfukRq5MIBFeoQh2lERc9Zjgz_WyOP-Xz_YBMXHYx" forHTTPHeaderField:@"Authorization"];
    NSString *urlString = [NSString stringWithFormat:@"https://api.yelp.com/v3/businesses/%@/reviews" ,cafeId ];
    NSURL *url = [NSURL URLWithString:urlString];
    [urlRequest setURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 3
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *allData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]; // 2
        
        if (jsonError) { // 3
            // Handle the error
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        NSArray* reviews = allData[@"reviews"];
        NSLog(@"reviews = %@",reviews);
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //UPDATES for UI in here
            [self.delegate recieveData:reviews];
        }];
    }];
    
    [dataTask resume];
}

@end


