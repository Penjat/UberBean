//
//  DetailViewController.h
//  UberBean
//
//  Created by Spencer Symington on 2019-01-26.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cafe.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)Cafe *cafe;
@end

NS_ASSUME_NONNULL_END
