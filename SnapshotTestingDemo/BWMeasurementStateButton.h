//
//  BWMeasurementStateButton.h
//  Wheel
//
//  Created by joshua may on 12/11/2014.
//  Copyright (c) 2014 BioWink GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BWCrossView;
@class BWMeasurementIconView;

IB_DESIGNABLE
@interface BWMeasurementStateButton : UIButton

- (instancetype)initWithDeselectIndictorPosition:(UIRectCorner)deselectIndictorPosition;

@property (nonatomic, strong, readonly) UILabel *label;
@property (nonatomic, strong, readonly) BWMeasurementIconView *icon;
@property (nonatomic, strong, readonly) BWCrossView *deselectIndicator;

// TARGET_INTERFACE_BUILDER-ish
@property (nonatomic, copy) IBInspectable NSString *labelText;
@property (nonatomic, assign) IBInspectable BOOL deselectIndicatorVisible;

@property (nonatomic, strong) IBInspectable UIColor *baseColor;
@property (nonatomic, strong) IBInspectable UIColor *highlightColor;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

@end
