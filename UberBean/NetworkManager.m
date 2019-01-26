//
//  NetworkManager.m
//  UberBean
//
//  Created by Spencer Symington on 2019-01-26.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

-(void)getYelpData{
    NSLog(@"getting the yelp data");
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc]init];
    
    [urlRequest addValue:@"Bearer sNLOf-pW5pM381GYYBVWmRmN1p0iGqJA9Nrsz4vJF0_qB5FLIFZtSXnQZbmDDnIJTkTtxqpJdz8Bup6KXuctGcGdfukRq5MIBFeoQh2lERc9Zjgz_WyOP-Xz_YBMXHYx" forHTTPHeaderField:@"Authorization"];
    
    NSURL *url = [NSURL URLWithString:@"https://api.yelp.com/v3/businesses/search?term=cafe&latitude=49.281815&longitude=-123.108414"];
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
        NSDictionary *businessDictionary =  allData[@"businesses"];
        
        NSLog(@"first business = %@",businessDictionary =  allData[@"businesses"]
              [0]);
        
        
        
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //UPDATES for UI in here
        }];
    }];
    
    [dataTask resume];
}
@end
