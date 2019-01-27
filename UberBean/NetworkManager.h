//
//  NetworkManager.h
//  UberBean
//
//  Created by Spencer Symington on 2019-01-26.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DataReciever <NSObject>

-(void)recieveData:(NSArray*)data;

@end

@interface NetworkManager : NSObject

@property (weak,nonatomic)id<DataReciever>delegate;
-(void)getYelpDataWithLatitude:(float)latitude longitude:(float)longitude;

@end



NS_ASSUME_NONNULL_END
