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
                           andTitle:(NSString * _Nullable)aTitle
                        andSubtitle:(NSString * _Nullable)aSubtitle{
    self = [super init];
    if (self)
    {
        _coordinate = aCoordinate;
        _title = aTitle;
        _subtitle = aSubtitle;
    }
    return self;
}
@end
