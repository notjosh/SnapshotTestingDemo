//
//  BWMeasurementIconView.h
//  Wheel
//
//  Created by joshua may on 14/11/2014.
//  Copyright (c) 2014 BioWink GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface BWMeasurementIconView : UIView

@property (nonatomic, assign) IBInspectable CGFloat iconScale;

@property (nonatomic, strong) IBInspectable UIBezierPath *path;
@property (nonatomic, strong) IBInspectable UIColor *color;

- (CAShapeLayer *)shapeLayer;

@end
