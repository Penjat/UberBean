//
//  Cafe.h
//  UberBean
//
//  Created by Spencer Symington on 2019-01-26.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cafe : NSObject<MKAnnotation>

@property (nonatomic, readonly) NSDictionary *data;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy, nullable) NSString *title;
@property (nonatomic, readonly, copy, nullable) NSString *subtitle;
@property (nonatomic)float rating;
@property (nonatomic)int numberOfRatings;
@property (nonatomic)CLLocationDistance distance;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate
                           andData:(NSDictionary*)data;
-(CLLocationDistance)findDistance:(CLLocationCoordinate2D)ourLocation;
@end

NS_ASSUME_NONNULL_END
