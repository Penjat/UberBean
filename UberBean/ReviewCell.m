//
//  ReviewCell.m
//  UberBean
//
//  Created by Spencer Symington on 2019-01-27.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import "ReviewCell.h"

@interface ReviewCell()
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end

@implementation ReviewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setUpWithData:(NSDictionary*)data{
    
    self.reviewLabel.text = data[@"text"];
    
    int rating = [data[@"rating"] intValue];
    NSString *output = @"";
    for(int i=0;i<rating ;i++){
        output = [output stringByAppendingString:@"✰"];
        
    }
    self.ratingLabel.text = output;
}

@end
