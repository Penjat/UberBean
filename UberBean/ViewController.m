//
//  ViewController.m
//  UberBean
//
//  Created by Spencer Symington on 2019-01-25.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property CLLocationManager *locationManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager = [[CLLocationManager alloc]init];
    
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.delegate = self;
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(locations[0].coordinate.latitude,locations[0].coordinate.longitude);
    
    MKCoordinateRegion region =  MKCoordinateRegionMake(location, MKCoordinateSpanMake(0.06, 0.06));
    
    [_myMapView setRegion:region animated:YES];
    
    
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    [self.locationManager requestLocation];
}





@end
