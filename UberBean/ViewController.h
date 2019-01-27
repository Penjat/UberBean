//
//  ViewController.h
//  UberBean
//
//  Created by Spencer Symington on 2019-01-25.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "NetworkManager.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate,DataReciever>


@end

