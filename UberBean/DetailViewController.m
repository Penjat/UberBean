//
//  DetailViewController.m
//  UberBean
//
//  Created by Spencer Symington on 2019-01-26.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import "DetailViewController.h"
#import "CafeInfoCell.h"
#import "ReviewCell.h"


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
    
    [NetworkManager sharedInstance].delegate = self;
    [[NetworkManager sharedInstance] getYelpReviews:self.cafe.data[@"id"]];
    
    
    
}
- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"the view was loaded");
    [NetworkManager sharedInstance].delegate = self;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 460.0;
    }
    return 140.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    [label setTextAlignment:NSTextAlignmentCenter];
    NSString *string = @"Yelp reviews";
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    return view;
    
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    //the first section should show cafe data
    if(indexPath.section == 0){
        
        
        CafeInfoCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
        
        [cell setUpWithData:self.cafe];
        return cell;
    }
    
    ReviewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"reviewCell" forIndexPath:indexPath];
    [cell setUpWithData:self.reviewArray[indexPath.row]];
    //[cell setUpWithData:self.cafe];

    
//
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 1;
    }
    return self.reviewArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(void)recieveData:(NSArray*)data{
    NSLog(@"detail manager recieved data");
    self.reviewArray = data;
    [self.myTableView reloadData];
}



@end
