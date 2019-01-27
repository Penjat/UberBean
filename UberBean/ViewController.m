//
//  ViewController.m
//  UberBean
//
//  Created by Spencer Symington on 2019-01-25.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import "ViewController.h"
#import "Cafe.h"



@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property CLLocationManager *locationManager;
@property (strong,nonatomic) NetworkManager *networkManager;

@property (strong,nonatomic)NSMutableArray<Cafe*> *cafes;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.cafes = [[NSMutableArray alloc]init];
    self.locationManager = [[CLLocationManager alloc]init];
    self.networkManager = [[NetworkManager alloc]init];
    self.networkManager.delegate = self;
    
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.delegate = self;
    self.myMapView.delegate = self;
    
    [self getYelpData];
}
-(void)getYelpData{
    
    
    
    
    
}

-(void)recieveData:(NSArray <NSDictionary <NSString*,NSString*> *> *)data{
    NSLog(@"data recieved");
    NSLog(@"data[0] = %@",data[0]);
    
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc]init];
    
    myAnnotation.coordinate = CLLocationCoordinate2DMake(49.281422, -123.114626);
    
    [myAnnotation setTitle:@"LHL"];
    [myAnnotation setSubtitle:@"Where we currently are"];
    [_myMapView addAnnotation: myAnnotation];
    
    for(NSDictionary *dict in data){
        float latitude = [ dict[@"coordinates"][@"latitude"] floatValue];
        float longitude = [ dict[@"coordinates"][@"longitude"] floatValue];
        NSLog(@"lat = %f , lon = %f",latitude,longitude);
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake(latitude, longitude);
        
        
        
        Cafe *cafe = [[Cafe alloc]initWithCoordinate:location andTitle:dict[@"name"] andSubtitle:@"subtitle"];
        
        [self.myMapView addAnnotation: cafe];
        [self.cafes addObject:cafe];
    }
    
    NSLog(@"number of cafes = %li",self.cafes.count);
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(locations[0].coordinate.latitude,locations[0].coordinate.longitude);
    
    MKCoordinateRegion region =  MKCoordinateRegionMake(location, MKCoordinateSpanMake(0.06, 0.06));
    
    [_myMapView setRegion:region animated:YES];
    
    
    
    [self.networkManager getYelpDataWithLatitude:location.latitude longitude:location.longitude];
    
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    [self.locationManager requestLocation];
}





@end
