//
//  CafeInfoCell.h
//  UberBean
//
//  Created by Spencer Symington on 2019-01-27.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cafe.h"

NS_ASSUME_NONNULL_BEGIN

@interface CafeInfoCell : UITableViewCell
-(void)setUpWithData:(Cafe*)cafe;
@end

NS_ASSUME_NONNULL_END
