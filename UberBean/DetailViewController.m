//
//  DetailViewController.m
//  UberBean
//
//  Created by Spencer Symington on 2019-01-26.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import "DetailViewController.h"
#import "CafeInfoCell.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong,nonatomic)NSArray *reviewArray;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"cafe name is %@ image url is %@",self.cafe.title,self.cafe.data[@"image_url"]);
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
    self.reviewArray = [[NSArray alloc]init];
    
//    self.cafeNameLabel.text = self.cafe.title;
//    self.ratingLabel.text = self.cafe.subtitle;
//
//    NSArray<NSString*> *address = self.cafe.data[@"location"][@"display_address"];
//    self.addressLabel.text = [NSString stringWithFormat:@"%@ \n %@ \n %@" , address[0],address[1],address[2] ];
    
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 460.0;
    }
    return 50.0;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *cellId = @"infoCell";  // Reuse identifier
    
    
    
    CafeInfoCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
    
    [cell setUpWithData:self.cafe];

    
//
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 1;
    }
    return self.reviewArray.count;
}




@end
