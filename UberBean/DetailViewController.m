//
//  DetailViewController.m
//  UberBean
//
//  Created by Spencer Symington on 2019-01-26.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *cafeImage;
@property (weak, nonatomic) IBOutlet UILabel *cafeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"cafe name is %@ image url is %@",self.cafe.title,self.cafe.data[@"image_url"]);
    
    
    self.cafeNameLabel.text = self.cafe.title;
    self.ratingLabel.text = self.cafe.subtitle;
    
    NSArray<NSString*> *address = self.cafe.data[@"location"][@"display_address"];
    self.addressLabel.text = [NSString stringWithFormat:@"%@ \n %@ \n %@" , address[0],address[1],address[2] ];
    NSURL *url = [NSURL URLWithString:self.cafe.data[@"image_url"]];
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 2
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 3
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data]; // 2
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            
            self.cafeImage.image = image; // 4
        }];
        
    }];
    
    [downloadTask resume];
}



@end
