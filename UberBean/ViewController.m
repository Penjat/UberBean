//
//  ViewController.m
//  UberBean
//
//  Created by Spencer Symington on 2019-01-25.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import "ViewController.h"
#import "Cafe.h"
#import "AnnotationButton.h"
#import "DetailViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property CLLocationManager *locationManager;
@property (nonatomic)CLLocationCoordinate2D currentLocation;


@property (strong,nonatomic) Cafe *closestCafe;
@property (strong,nonatomic) Cafe *bestCafe;
@property (weak, nonatomic) IBOutlet UIButton *bestCafeButton;
@property (weak, nonatomic) IBOutlet UIButton *closestCafeButton;


@property (strong,nonatomic)NSMutableArray<Cafe*> *cafes;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.cafes = [[NSMutableArray alloc]init];
    self.locationManager = [[CLLocationManager alloc]init];
    
    [NetworkManager sharedInstance].delegate = self;
    
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.delegate = self;
    self.myMapView.delegate = self;
    [self.locationManager startUpdatingLocation];
    
}
- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"the view was loaded");
    [NetworkManager sharedInstance].delegate = self;
}

- (IBAction)goToBest:(id)sender {
    [self performSegueWithIdentifier:@"toDetails" sender:self.bestCafe];
}
- (IBAction)goToClosest:(id)sender {
    [self performSegueWithIdentifier:@"toDetails" sender:self.closestCafe];
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation{
    
    MKAnnotationView *anyView;
    if ([annotation isKindOfClass: [Cafe class]]){
        //////// VIEW
        anyView = [mapView dequeueReusableAnnotationViewWithIdentifier: @"pinId"];
        if (!anyView)
        {
            // If an existing pin view was not available, create one.
            anyView = [[MKAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"pinId"];
            anyView.canShowCallout = YES;
            
            if([annotation isEqual:self.bestCafe]){
                UIImage *image = [UIImage imageNamed:@"coffeeIconBlue.png"];
                
                anyView.image = image;
            
            }else{
                UIImage *image = [UIImage imageNamed:@"coffeeIcon.png"];
                
                anyView.image = image;
            }
            
            
            anyView.calloutOffset = CGPointMake(0, -32);
            AnnotationButton* rightButton = [AnnotationButton buttonWithType: UIButtonTypeDetailDisclosure];
            rightButton.cafe = annotation;
            
            [rightButton addTarget:self
                            action:@selector(pinPressed:)
                  forControlEvents:UIControlEventTouchUpInside];
            
            
            anyView.rightCalloutAccessoryView = rightButton;
            
            // Add an image to the left callout.
//            UIImageView *iconView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"lhlLogo.png"]];
//           anyView.leftCalloutAccessoryView = iconView;
        }
        else
        {
            anyView.annotation = annotation;
        }
    }
    return anyView;
}

-(void)pinPressed:(AnnotationButton*)button{
    NSLog(@"pin pressed");
    
    [self performSegueWithIdentifier:@"toDetails" sender:button.cafe];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DetailViewController *details = (DetailViewController*)segue.destinationViewController;
    
    details.cafe = (Cafe*)sender;
    
}
-(void)recieveData:(NSArray <NSDictionary <NSString*,NSString*> *> *)data{
    NSLog(@"data recieved");
    //NSLog(@"data[0] = %@",data[0]);
    
    
    
    
    for(NSDictionary *dict in data){
        float latitude = [ dict[@"coordinates"][@"latitude"] floatValue];
        float longitude = [ dict[@"coordinates"][@"longitude"] floatValue];
        //NSLog(@"lat = %f , lon = %f",latitude,longitude);
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake(latitude, longitude);
        
        
        
        Cafe *cafe = [[Cafe alloc]initWithCoordinate:location andData:dict];
        [cafe findDistance:self.currentLocation];
        
        [self checkForBestAndClosestCafe:cafe];
        
        
        [self.myMapView addAnnotation: cafe];
        [self.cafes addObject:cafe];
    }
    [self updateBestAndClosest];
    
    
}
-(void)checkForBestAndClosestCafe:(Cafe*)cafe{
    //check if is closest
    if(self.closestCafe == nil || self.closestCafe.distance > cafe.distance){
        self.closestCafe = cafe;
    }
    //check if best
    if(self.bestCafe == nil ){
        self.bestCafe = cafe;
    }else if(self.bestCafe.rating < cafe.rating){
        self.bestCafe = cafe;
    }else if(self.bestCafe.rating == cafe.rating && self.bestCafe.numberOfRatings < cafe.numberOfRatings){
        self.bestCafe = cafe;
    }
}
-(void)updateBestAndClosest{
    if(self.bestCafe != nil){
        
        [self.bestCafeButton setTitle:[NSString stringWithFormat:@"%@ %@", self.bestCafe.title ,self.bestCafe.subtitle] forState:UIControlStateNormal];
    }
    
    if(self.closestCafe != nil){
        [self.closestCafeButton setTitle:[NSString stringWithFormat:@"%@ %@", self.closestCafe.title ,self.closestCafe.subtitle] forState:UIControlStateNormal];
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"update location");
    self.currentLocation = CLLocationCoordinate2DMake(locations[0].coordinate.latitude,locations[0].coordinate.longitude);
    
    
    MKCoordinateRegion region =  MKCoordinateRegionMake(self.currentLocation, MKCoordinateSpanMake(0.06, 0.06));
    
    [_myMapView setRegion:region animated:YES];
    
    
    
    [[NetworkManager sharedInstance] getYelpDataWithLatitude:self.currentLocation.latitude longitude:self.currentLocation.longitude];
    for(Cafe *cafe in self.cafes){
        [cafe findDistance:self.currentLocation];
        
        [self checkForBestAndClosestCafe:cafe];
        
    }
    [self updateBestAndClosest];
    NSLog(@"the closest cafe is %@",self.closestCafe.title);
    
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    [self.locationManager requestLocation];
}





@end
