//
//  Cafe.m
//  UberBean
//
//  Created by Spencer Symington on 2019-01-26.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import "Cafe.h"

@implementation Cafe
- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate
                           andData:(NSDictionary*)data{
    self = [super init];
    if (self)
    {
        _coordinate = aCoordinate;
        
        
        _title = data[@"name"];
        _rating = [data[@"rating"] floatValue];
        _numberOfRatings = [data[@"review_count"] intValue];
        _subtitle = [self getRating:_rating];
        _data = data;
        
    }
    return self;
}

-(NSString*)getRating:(float)rating{
    
    NSString *output = @"";
    for(int i=0;i<rating ;i++){
        output = [output stringByAppendingString:@"✰"];
        
    }
    return output;
}
-(CLLocationDistance)findDistance:(CLLocationCoordinate2D)ourLocation{
    
    MKMapPoint point1 = MKMapPointForCoordinate(ourLocation);
    MKMapPoint point2 = MKMapPointForCoordinate(self.coordinate);
    
    self.distance = MKMetersBetweenMapPoints(point1, point2);
    
    return self.distance;
}
@end
