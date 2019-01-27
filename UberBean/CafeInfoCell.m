//
//  CafeInfoCell.m
//  UberBean
//
//  Created by Spencer Symington on 2019-01-27.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import "CafeInfoCell.h"


@interface CafeInfoCell()

@property (weak, nonatomic) IBOutlet UIImageView *cafeImage;
@property (weak, nonatomic) IBOutlet UILabel *cafeName;
@property (weak, nonatomic) IBOutlet UILabel *cafeRating;
@property (weak, nonatomic) IBOutlet UILabel *cafeAddress;


@end

@implementation CafeInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setUpWithData:(Cafe*)cafe{
        self.cafeName.text = cafe.title;
        self.cafeRating.text = cafe.subtitle;
    
        NSArray<NSString*> *address = cafe.data[@"location"][@"display_address"];
        self.cafeAddress.text = [NSString stringWithFormat:@"%@ \n %@ \n %@" , address[0],address[1],address[2] ];
    
    //TODO create singelton of network manager
    NSURL *url = [NSURL URLWithString:cafe.data[@"image_url"]];
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
            self.cafeImage.image = image;
            
        }];
        
    }];
    
    [downloadTask resume];
}
@end


