//
//  BWCrossView.h
//  Wheel
//
//  Created by joshua may on 13/11/2014.
//  Copyright (c) 2014 BioWink GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface BWCrossView : UIView

@property (nonatomic, copy) UIColor *color;

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGLineCap lineCap;

@end
