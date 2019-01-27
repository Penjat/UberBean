//
//  annotationButton.h
//  UberBean
//
//  Created by Spencer Symington on 2019-01-26.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Cafe;


NS_ASSUME_NONNULL_BEGIN

@interface AnnotationButton : UIButton
@property (weak,nonatomic) Cafe *cafe;
@end

NS_ASSUME_NONNULL_END
