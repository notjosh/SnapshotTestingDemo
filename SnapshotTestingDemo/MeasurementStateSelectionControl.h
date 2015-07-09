//
//  MeasurementStateSelectionControl.h
//  Wheel
//
//  Created by BioWink GmbH on 11/23/12.
//  Copyright (c) 2013 BioWink GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const MeasurementStateSelectionControlModelKeyTitle;
extern NSString * const MeasurementStateSelectionControlModelKeyPath;
extern NSString * const MeasurementStateSelectionControlModelKeyAccessibilityLabel;

@interface MeasurementStateSelectionControl : UIControl

@property (nonatomic, copy) NSArray *buttonParameters;
@property (nonatomic, copy) UIColor *color;

@property (nonatomic, copy) NSArray *selectedIndices;

@property (nonatomic, assign) BOOL allowsMultiSelect;

@end