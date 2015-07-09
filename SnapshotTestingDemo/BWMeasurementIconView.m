//
//  BWMeasurementIconView.m
//  Wheel
//
//  Created by joshua may on 14/11/2014.
//  Copyright (c) 2014 BioWink GmbH. All rights reserved.
//

#import "BWMeasurementIconView.h"

#define DEMO 1

@interface BWMeasurementIconView ()

@property (nonatomic, assign) CGRect drawBounds;

@property (nonatomic, assign, getter=isInited) BOOL inited;

@end

@implementation BWMeasurementIconView

+ (Class)layerClass
{
    return CAShapeLayer.class;
}

- (instancetype)init {
    self = [super init];

    if (self) {
        [self commonInit];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        [self commonInit];
    }

    return self;
}

- (instancetype)initWithCoder:(nonnull NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self commonInit];
    }

    return self;
}

- (void)commonInit
{
    if (self.isInited) {
        return;
    }

    self.inited = YES;

    self.layer.actions = @{
                           @"onOrderIn":  [NSNull null],
                           @"onOrderOut": [NSNull null],
                           @"sublayers":  [NSNull null],
                           @"contents":   [NSNull null],
                           @"bounds":     [NSNull null],
                           };

    _iconScale = 1.f;

    self.shapeLayer.lineWidth = 0.f;

#if TARGET_INTERFACE_BUILDER || DEMO
    self.shapeLayer.fillColor = [UIColor blueColor].CGColor;

    _path = [self sexProtected];
//    _path = [self moodHappy];
#endif
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];

    _drawBounds = CGRectZero; //????????
    self.drawBounds = self.bounds;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.drawBounds = self.bounds;
}

- (void)setNeedsDisplay
{
    [super setNeedsDisplay];

    _drawBounds = CGRectZero;
}

#pragma mark - API

- (void)setIconScale:(CGFloat)iconScale
{
    _iconScale = iconScale;

    [self updatePathWithBounds:self.drawBounds];
}

- (void)setPath:(UIBezierPath *)path
{
    _path = path;

    [self setNeedsDisplay];
}

- (CAShapeLayer *)shapeLayer
{
    return (CAShapeLayer *)self.layer;
}

#pragma mark - Accessor

- (void)setDrawBounds:(CGRect)drawBounds
{
    // reset to zero
    if (CGRectEqualToRect(drawBounds, CGRectZero)) {
        _drawBounds = CGRectZero;
        return;
    }

    // actual draw routine
    if (CGRectEqualToRect(_drawBounds, CGRectZero)) {
        _drawBounds = drawBounds;
        [self updatePathWithBounds:drawBounds];
    }
}

- (void)setColor:(UIColor *)color {
    _color = color;

    self.shapeLayer.fillColor = self.color.CGColor;

    [self setNeedsDisplay];
}

#if TARGET_INTERFACE_BUILDER
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];

    [self updatePathWithBounds:self.bounds];
}
#endif

#if TARGET_INTERFACE_BUILDER || DEMO
- (UIBezierPath *)sexProtected {
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(154.55f, 103.76f)];
    [bezierPath addCurveToPoint: CGPointMake(154.25f, 104.58f) controlPoint1: CGPointMake(154.58f, 104.08f) controlPoint2: CGPointMake(154.47f, 104.35f)];
    [bezierPath addLineToPoint: CGPointMake(146.96f, 112.64f)];
    [bezierPath addCurveToPoint: CGPointMake(146.18f, 113.5f) controlPoint1: CGPointMake(146.76f, 112.85f) controlPoint2: CGPointMake(146.47f, 113.5f)];
    [bezierPath addCurveToPoint: CGPointMake(146.18f, 113.5f) controlPoint1: CGPointMake(146.18f, 113.5f) controlPoint2: CGPointMake(146.18f, 113.5f)];
    [bezierPath addLineToPoint: CGPointMake(88.83f, 112.89f)];
    [bezierPath addLineToPoint: CGPointMake(90.56f, 114.79f)];
    [bezierPath addCurveToPoint: CGPointMake(90.43f, 116.14f) controlPoint1: CGPointMake(90.94f, 115.25f) controlPoint2: CGPointMake(90.88f, 115.76f)];
    [bezierPath addLineToPoint: CGPointMake(87.78f, 118.32f)];
    [bezierPath addCurveToPoint: CGPointMake(87.07f, 118.54f) controlPoint1: CGPointMake(87.58f, 118.49f) controlPoint2: CGPointMake(87.33f, 118.54f)];
    [bezierPath addCurveToPoint: CGPointMake(86.54f, 118.38f) controlPoint1: CGPointMake(86.89f, 118.54f) controlPoint2: CGPointMake(86.7f, 118.47f)];
    [bezierPath addLineToPoint: CGPointMake(78.51f, 113.86f)];
    [bezierPath addLineToPoint: CGPointMake(46.16f, 113.77f)];
    [bezierPath addCurveToPoint: CGPointMake(45.07f, 112.71f) controlPoint1: CGPointMake(45.57f, 113.77f) controlPoint2: CGPointMake(45.09f, 113.3f)];
    [bezierPath addLineToPoint: CGPointMake(44.41f, 87.36f)];
    [bezierPath addCurveToPoint: CGPointMake(44.79f, 86.5f) controlPoint1: CGPointMake(44.4f, 87.03f) controlPoint2: CGPointMake(44.54f, 86.71f)];
    [bezierPath addLineToPoint: CGPointMake(50.56f, 81.56f)];
    [bezierPath addCurveToPoint: CGPointMake(43.19f, 72.7f) controlPoint1: CGPointMake(46.37f, 80.79f) controlPoint2: CGPointMake(43.19f, 77.11f)];
    [bezierPath addCurveToPoint: CGPointMake(52.2f, 63.69f) controlPoint1: CGPointMake(43.19f, 67.73f) controlPoint2: CGPointMake(47.23f, 63.69f)];
    [bezierPath addCurveToPoint: CGPointMake(61.22f, 72.7f) controlPoint1: CGPointMake(57.17f, 63.69f) controlPoint2: CGPointMake(61.22f, 67.73f)];
    [bezierPath addCurveToPoint: CGPointMake(60.05f, 77.12f) controlPoint1: CGPointMake(61.22f, 74.26f) controlPoint2: CGPointMake(60.81f, 75.78f)];
    [bezierPath addLineToPoint: CGPointMake(99.05f, 72.88f)];
    [bezierPath addCurveToPoint: CGPointMake(99.32f, 72.88f) controlPoint1: CGPointMake(99.14f, 72.87f) controlPoint2: CGPointMake(99.23f, 72.87f)];
    [bezierPath addLineToPoint: CGPointMake(105.79f, 73.73f)];
    [bezierPath addCurveToPoint: CGPointMake(106.55f, 74.21f) controlPoint1: CGPointMake(106.1f, 73.77f) controlPoint2: CGPointMake(106.38f, 73.95f)];
    [bezierPath addLineToPoint: CGPointMake(110.85f, 80.59f)];
    [bezierPath addCurveToPoint: CGPointMake(110.68f, 82.01f) controlPoint1: CGPointMake(111.15f, 81.04f) controlPoint2: CGPointMake(111.08f, 81.64f)];
    [bezierPath addLineToPoint: CGPointMake(109.38f, 83.18f)];
    [bezierPath addCurveToPoint: CGPointMake(107.94f, 83.21f) controlPoint1: CGPointMake(108.97f, 83.55f) controlPoint2: CGPointMake(108.36f, 83.56f)];
    [bezierPath addLineToPoint: CGPointMake(103.48f, 79.48f)];
    [bezierPath addLineToPoint: CGPointMake(102.06f, 79.37f)];
    [bezierPath addLineToPoint: CGPointMake(123.1f, 103.69f)];
    [bezierPath addCurveToPoint: CGPointMake(123.32f, 103.95f) controlPoint1: CGPointMake(123.19f, 103.76f) controlPoint2: CGPointMake(123.26f, 103.85f)];
    [bezierPath addLineToPoint: CGPointMake(141.22f, 106.65f)];
    [bezierPath addLineToPoint: CGPointMake(151.03f, 101.5f)];
    [bezierPath addCurveToPoint: CGPointMake(152.18f, 101.58f) controlPoint1: CGPointMake(151.4f, 101.3f) controlPoint2: CGPointMake(151.85f, 101.34f)];
    [bezierPath addLineToPoint: CGPointMake(154.11f, 103.f)];
    [bezierPath addCurveToPoint: CGPointMake(154.55f, 103.76f) controlPoint1: CGPointMake(154.37f, 103.19f) controlPoint2: CGPointMake(154.53f, 103.44f)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(111.57f, 102.13f)];
    [bezierPath addLineToPoint: CGPointMake(98.f, 90.32f)];
    [bezierPath addLineToPoint: CGPointMake(90.23f, 98.89f)];
    [bezierPath addLineToPoint: CGPointMake(111.57f, 102.13f)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(91.01f, 79.6f)];
    [bezierPath addLineToPoint: CGPointMake(73.14f, 84.43f)];
    [bezierPath addLineToPoint: CGPointMake(77.83f, 90.23f)];
    [bezierPath addLineToPoint: CGPointMake(91.01f, 79.6f)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(63.31f, 106.36f)];
    [bezierPath addLineToPoint: CGPointMake(54.63f, 98.56f)];
    [bezierPath addLineToPoint: CGPointMake(53.98f, 105.29f)];
    [bezierPath addLineToPoint: CGPointMake(63.31f, 106.36f)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(78.28f, 107.25f)];
    [bezierPath addLineToPoint: CGPointMake(77.08f, 98.82f)];
    [bezierPath addLineToPoint: CGPointMake(61.5f, 85.16f)];
    [bezierPath addLineToPoint: CGPointMake(61.5f, 79.75f)];
    [bezierPath addLineToPoint: CGPointMake(58.3f, 79.19f)];
    [bezierPath addLineToPoint: CGPointMake(54.5f, 81.45f)];
    [bezierPath addLineToPoint: CGPointMake(54.5f, 83.26f)];
    [bezierPath addLineToPoint: CGPointMake(60.33f, 85.52f)];
    [bezierPath addLineToPoint: CGPointMake(69.86f, 104.99f)];
    [bezierPath addLineToPoint: CGPointMake(78.28f, 107.25f)];
    [bezierPath closePath];

    return bezierPath;
}

- (UIBezierPath *)moodHappy {
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(94.f, 125.17f)];
    [bezierPath addCurveToPoint: CGPointMake(62.83f, 94.f) controlPoint1: CGPointMake(76.79f, 125.17f) controlPoint2: CGPointMake(62.83f, 111.21f)];
    [bezierPath addCurveToPoint: CGPointMake(94.f, 62.83f) controlPoint1: CGPointMake(62.83f, 76.79f) controlPoint2: CGPointMake(76.79f, 62.83f)];
    [bezierPath addCurveToPoint: CGPointMake(125.17f, 94.f) controlPoint1: CGPointMake(111.21f, 62.83f) controlPoint2: CGPointMake(125.17f, 76.79f)];
    [bezierPath addCurveToPoint: CGPointMake(94.f, 125.17f) controlPoint1: CGPointMake(125.17f, 111.21f) controlPoint2: CGPointMake(111.21f, 125.17f)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(103.1f, 78.54f)];
    [bezierPath addCurveToPoint: CGPointMake(98.83f, 85.35f) controlPoint1: CGPointMake(100.74f, 78.54f) controlPoint2: CGPointMake(98.83f, 81.59f)];
    [bezierPath addCurveToPoint: CGPointMake(103.1f, 92.16f) controlPoint1: CGPointMake(98.83f, 89.11f) controlPoint2: CGPointMake(100.74f, 92.16f)];
    [bezierPath addCurveToPoint: CGPointMake(107.37f, 85.35f) controlPoint1: CGPointMake(105.46f, 92.16f) controlPoint2: CGPointMake(107.37f, 89.11f)];
    [bezierPath addCurveToPoint: CGPointMake(103.1f, 78.54f) controlPoint1: CGPointMake(107.37f, 81.59f) controlPoint2: CGPointMake(105.46f, 78.54f)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(84.9f, 78.87f)];
    [bezierPath addCurveToPoint: CGPointMake(80.63f, 85.68f) controlPoint1: CGPointMake(82.54f, 78.87f) controlPoint2: CGPointMake(80.63f, 81.92f)];
    [bezierPath addCurveToPoint: CGPointMake(84.9f, 92.49f) controlPoint1: CGPointMake(80.63f, 89.44f) controlPoint2: CGPointMake(82.54f, 92.49f)];
    [bezierPath addCurveToPoint: CGPointMake(89.17f, 85.68f) controlPoint1: CGPointMake(87.25f, 92.49f) controlPoint2: CGPointMake(89.17f, 89.44f)];
    [bezierPath addCurveToPoint: CGPointMake(84.9f, 78.87f) controlPoint1: CGPointMake(89.17f, 81.92f) controlPoint2: CGPointMake(87.25f, 78.87f)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(110.21f, 103.63f)];
    [bezierPath addCurveToPoint: CGPointMake(109.49f, 101.15f) controlPoint1: CGPointMake(110.69f, 102.75f) controlPoint2: CGPointMake(110.37f, 101.64f)];
    [bezierPath addCurveToPoint: CGPointMake(107.01f, 101.87f) controlPoint1: CGPointMake(108.61f, 100.67f) controlPoint2: CGPointMake(107.5f, 100.99f)];
    [bezierPath addCurveToPoint: CGPointMake(89.74f, 107.3f) controlPoint1: CGPointMake(104.18f, 107.02f) controlPoint2: CGPointMake(93.04f, 108.39f)];
    [bezierPath addCurveToPoint: CGPointMake(87.44f, 108.45f) controlPoint1: CGPointMake(88.78f, 106.98f) controlPoint2: CGPointMake(87.75f, 107.5f)];
    [bezierPath addCurveToPoint: CGPointMake(88.59f, 110.76f) controlPoint1: CGPointMake(87.12f, 109.41f) controlPoint2: CGPointMake(87.64f, 110.44f)];
    [bezierPath addCurveToPoint: CGPointMake(92.79f, 111.27f) controlPoint1: CGPointMake(89.59f, 111.09f) controlPoint2: CGPointMake(91.06f, 111.27f)];
    [bezierPath addCurveToPoint: CGPointMake(110.21f, 103.63f) controlPoint1: CGPointMake(98.55f, 111.27f) controlPoint2: CGPointMake(107.12f, 109.22f)];
    [bezierPath closePath];

    [bezierPath moveToPoint: CGPointMake(94.f, 57.f)];
    [bezierPath addCurveToPoint: CGPointMake(90.76f, 53.76f) controlPoint1: CGPointMake(92.21f, 57.f) controlPoint2: CGPointMake(90.76f, 55.55f)];
    [bezierPath addLineToPoint: CGPointMake(90.76f, 49.1f)];
    [bezierPath addCurveToPoint: CGPointMake(94.f, 45.86f) controlPoint1: CGPointMake(90.76f, 47.31f) controlPoint2: CGPointMake(92.21f, 45.86f)];
    [bezierPath addCurveToPoint: CGPointMake(97.24f, 49.1f) controlPoint1: CGPointMake(95.79f, 45.86f) controlPoint2: CGPointMake(97.24f, 47.31f)];
    [bezierPath addLineToPoint: CGPointMake(97.24f, 53.76f)];
    [bezierPath addCurveToPoint: CGPointMake(94.f, 57.f) controlPoint1: CGPointMake(97.24f, 55.54f) controlPoint2: CGPointMake(95.79f, 57.f)];
    [bezierPath closePath];

    [bezierPath moveToPoint: CGPointMake(94.01f, 135.16f)];
    [bezierPath addCurveToPoint: CGPointMake(90.76f, 131.92f) controlPoint1: CGPointMake(92.22f, 135.16f) controlPoint2: CGPointMake(90.76f, 133.71f)];
    [bezierPath addCurveToPoint: CGPointMake(94.f, 128.68f) controlPoint1: CGPointMake(90.76f, 130.13f) controlPoint2: CGPointMake(92.21f, 128.68f)];
    [bezierPath addLineToPoint: CGPointMake(94.01f, 128.68f)];
    [bezierPath addCurveToPoint: CGPointMake(97.25f, 131.92f) controlPoint1: CGPointMake(95.79f, 128.68f) controlPoint2: CGPointMake(97.25f, 130.13f)];
    [bezierPath addCurveToPoint: CGPointMake(94.01f, 135.16f) controlPoint1: CGPointMake(97.25f, 133.71f) controlPoint2: CGPointMake(95.8f, 135.16f)];
    [bezierPath closePath];

    [bezierPath moveToPoint: CGPointMake(68.13f, 66.41f)];
    [bezierPath addCurveToPoint: CGPointMake(65.65f, 65.25f) controlPoint1: CGPointMake(67.21f, 66.41f) controlPoint2: CGPointMake(66.29f, 66.02f)];
    [bezierPath addLineToPoint: CGPointMake(62.65f, 61.68f)];
    [bezierPath addCurveToPoint: CGPointMake(63.06f, 57.12f) controlPoint1: CGPointMake(61.51f, 60.31f) controlPoint2: CGPointMake(61.68f, 58.27f)];
    [bezierPath addCurveToPoint: CGPointMake(67.62f, 57.52f) controlPoint1: CGPointMake(64.43f, 55.97f) controlPoint2: CGPointMake(66.47f, 56.15f)];
    [bezierPath addLineToPoint: CGPointMake(70.61f, 61.09f)];
    [bezierPath addCurveToPoint: CGPointMake(70.21f, 65.65f) controlPoint1: CGPointMake(71.76f, 62.46f) controlPoint2: CGPointMake(71.58f, 64.5f)];
    [bezierPath addCurveToPoint: CGPointMake(68.13f, 66.41f) controlPoint1: CGPointMake(69.61f, 66.16f) controlPoint2: CGPointMake(68.87f, 66.41f)];
    [bezierPath closePath];

    [bezierPath moveToPoint: CGPointMake(118.38f, 126.28f)];
    [bezierPath addCurveToPoint: CGPointMake(115.14f, 123.05f) controlPoint1: CGPointMake(116.59f, 126.28f) controlPoint2: CGPointMake(115.14f, 124.83f)];
    [bezierPath addCurveToPoint: CGPointMake(118.37f, 119.81f) controlPoint1: CGPointMake(115.14f, 121.26f) controlPoint2: CGPointMake(116.58f, 119.81f)];
    [bezierPath addLineToPoint: CGPointMake(118.38f, 119.81f)];
    [bezierPath addCurveToPoint: CGPointMake(121.62f, 123.05f) controlPoint1: CGPointMake(120.17f, 119.81f) controlPoint2: CGPointMake(121.62f, 121.26f)];
    [bezierPath addCurveToPoint: CGPointMake(118.38f, 126.28f) controlPoint1: CGPointMake(121.62f, 124.83f) controlPoint2: CGPointMake(120.17f, 126.28f)];
    [bezierPath closePath];

    [bezierPath moveToPoint: CGPointMake(54.37f, 90.25f)];
    [bezierPath addCurveToPoint: CGPointMake(53.8f, 90.2f) controlPoint1: CGPointMake(54.18f, 90.25f) controlPoint2: CGPointMake(53.99f, 90.24f)];
    [bezierPath addLineToPoint: CGPointMake(49.22f, 89.39f)];
    [bezierPath addCurveToPoint: CGPointMake(46.59f, 85.64f) controlPoint1: CGPointMake(47.45f, 89.08f) controlPoint2: CGPointMake(46.28f, 87.4f)];
    [bezierPath addCurveToPoint: CGPointMake(50.34f, 83.01f) controlPoint1: CGPointMake(46.9f, 83.88f) controlPoint2: CGPointMake(48.58f, 82.7f)];
    [bezierPath addLineToPoint: CGPointMake(54.93f, 83.82f)];
    [bezierPath addCurveToPoint: CGPointMake(57.56f, 87.57f) controlPoint1: CGPointMake(56.69f, 84.13f) controlPoint2: CGPointMake(57.87f, 85.81f)];
    [bezierPath addCurveToPoint: CGPointMake(54.37f, 90.25f) controlPoint1: CGPointMake(57.28f, 89.15f) controlPoint2: CGPointMake(55.91f, 90.25f)];
    [bezierPath closePath];

    [bezierPath moveToPoint: CGPointMake(131.35f, 103.82f)];
    [bezierPath addCurveToPoint: CGPointMake(128.11f, 100.59f) controlPoint1: CGPointMake(129.56f, 103.82f) controlPoint2: CGPointMake(128.11f, 102.38f)];
    [bezierPath addCurveToPoint: CGPointMake(131.34f, 97.35f) controlPoint1: CGPointMake(128.11f, 98.8f) controlPoint2: CGPointMake(129.55f, 97.35f)];
    [bezierPath addLineToPoint: CGPointMake(131.35f, 97.35f)];
    [bezierPath addCurveToPoint: CGPointMake(134.59f, 100.59f) controlPoint1: CGPointMake(133.14f, 97.35f) controlPoint2: CGPointMake(134.59f, 98.8f)];
    [bezierPath addCurveToPoint: CGPointMake(131.35f, 103.82f) controlPoint1: CGPointMake(134.59f, 102.38f) controlPoint2: CGPointMake(133.14f, 103.82f)];
    [bezierPath closePath];

    [bezierPath moveToPoint: CGPointMake(55.12f, 119.69f)];
    [bezierPath addCurveToPoint: CGPointMake(52.31f, 118.07f) controlPoint1: CGPointMake(54.f, 119.69f) controlPoint2: CGPointMake(52.91f, 119.11f)];
    [bezierPath addCurveToPoint: CGPointMake(53.49f, 113.65f) controlPoint1: CGPointMake(51.41f, 116.52f) controlPoint2: CGPointMake(51.94f, 114.54f)];
    [bezierPath addLineToPoint: CGPointMake(57.53f, 111.32f)];
    [bezierPath addCurveToPoint: CGPointMake(61.96f, 112.5f) controlPoint1: CGPointMake(59.08f, 110.42f) controlPoint2: CGPointMake(61.06f, 110.96f)];
    [bezierPath addCurveToPoint: CGPointMake(60.77f, 116.93f) controlPoint1: CGPointMake(62.85f, 114.06f) controlPoint2: CGPointMake(62.32f, 116.04f)];
    [bezierPath addLineToPoint: CGPointMake(56.74f, 119.26f)];
    [bezierPath addCurveToPoint: CGPointMake(55.12f, 119.69f) controlPoint1: CGPointMake(56.22f, 119.55f) controlPoint2: CGPointMake(55.67f, 119.69f)];
    [bezierPath closePath];

    [bezierPath moveToPoint: CGPointMake(126.85f, 78.28f)];
    [bezierPath addCurveToPoint: CGPointMake(123.6f, 75.04f) controlPoint1: CGPointMake(125.06f, 78.28f) controlPoint2: CGPointMake(123.6f, 76.83f)];
    [bezierPath addCurveToPoint: CGPointMake(126.84f, 71.8f) controlPoint1: CGPointMake(123.6f, 73.25f) controlPoint2: CGPointMake(125.05f, 71.8f)];
    [bezierPath addLineToPoint: CGPointMake(126.85f, 71.8f)];
    [bezierPath addCurveToPoint: CGPointMake(130.08f, 75.04f) controlPoint1: CGPointMake(128.63f, 71.8f) controlPoint2: CGPointMake(130.08f, 73.25f)];
    [bezierPath addCurveToPoint: CGPointMake(126.85f, 78.28f) controlPoint1: CGPointMake(130.08f, 76.83f) controlPoint2: CGPointMake(128.63f, 78.28f)];
    [bezierPath closePath];

    [bezierPath moveToPoint: CGPointMake(78.64f, 139.44f)];
    [bezierPath addCurveToPoint: CGPointMake(77.53f, 139.24f) controlPoint1: CGPointMake(78.27f, 139.44f) controlPoint2: CGPointMake(77.9f, 139.38f)];
    [bezierPath addCurveToPoint: CGPointMake(75.6f, 135.09f) controlPoint1: CGPointMake(75.85f, 138.63f) controlPoint2: CGPointMake(74.99f, 136.77f)];
    [bezierPath addLineToPoint: CGPointMake(77.19f, 130.71f)];
    [bezierPath addCurveToPoint: CGPointMake(81.35f, 128.77f) controlPoint1: CGPointMake(77.81f, 129.03f) controlPoint2: CGPointMake(79.67f, 128.16f)];
    [bezierPath addCurveToPoint: CGPointMake(83.28f, 132.93f) controlPoint1: CGPointMake(83.03f, 129.39f) controlPoint2: CGPointMake(83.89f, 131.25f)];
    [bezierPath addLineToPoint: CGPointMake(81.69f, 137.31f)];
    [bezierPath addCurveToPoint: CGPointMake(78.64f, 139.44f) controlPoint1: CGPointMake(81.21f, 138.62f) controlPoint2: CGPointMake(79.96f, 139.44f)];
    [bezierPath closePath];

    [bezierPath moveToPoint: CGPointMake(106.98f, 61.61f)];
    [bezierPath addCurveToPoint: CGPointMake(103.73f, 58.37f) controlPoint1: CGPointMake(105.19f, 61.61f) controlPoint2: CGPointMake(103.73f, 60.16f)];
    [bezierPath addCurveToPoint: CGPointMake(106.97f, 55.13f) controlPoint1: CGPointMake(103.73f, 56.58f) controlPoint2: CGPointMake(105.18f, 55.13f)];
    [bezierPath addLineToPoint: CGPointMake(106.98f, 55.13f)];
    [bezierPath addCurveToPoint: CGPointMake(110.22f, 58.37f) controlPoint1: CGPointMake(108.77f, 55.13f) controlPoint2: CGPointMake(110.22f, 56.58f)];
    [bezierPath addCurveToPoint: CGPointMake(106.98f, 61.61f) controlPoint1: CGPointMake(110.22f, 60.16f) controlPoint2: CGPointMake(108.77f, 61.61f)];
    [bezierPath closePath];

    [bezierPath moveToPoint: CGPointMake(109.36f, 139.44f)];
    [bezierPath addCurveToPoint: CGPointMake(106.31f, 137.31f) controlPoint1: CGPointMake(108.04f, 139.44f) controlPoint2: CGPointMake(106.79f, 138.62f)];
    [bezierPath addLineToPoint: CGPointMake(104.72f, 132.93f)];
    [bezierPath addCurveToPoint: CGPointMake(106.65f, 128.77f) controlPoint1: CGPointMake(104.11f, 131.24f) controlPoint2: CGPointMake(104.97f, 129.39f)];
    [bezierPath addCurveToPoint: CGPointMake(110.81f, 130.71f) controlPoint1: CGPointMake(108.33f, 128.16f) controlPoint2: CGPointMake(110.2f, 129.03f)];
    [bezierPath addLineToPoint: CGPointMake(112.4f, 135.09f)];
    [bezierPath addCurveToPoint: CGPointMake(110.47f, 139.24f) controlPoint1: CGPointMake(113.01f, 136.77f) controlPoint2: CGPointMake(112.15f, 138.63f)];
    [bezierPath addCurveToPoint: CGPointMake(109.36f, 139.44f) controlPoint1: CGPointMake(110.1f, 139.37f) controlPoint2: CGPointMake(109.73f, 139.44f)];
    [bezierPath closePath];

    [bezierPath moveToPoint: CGPointMake(81.04f, 61.61f)];
    [bezierPath addCurveToPoint: CGPointMake(77.79f, 58.37f) controlPoint1: CGPointMake(79.25f, 61.61f) controlPoint2: CGPointMake(77.79f, 60.16f)];
    [bezierPath addCurveToPoint: CGPointMake(81.03f, 55.13f) controlPoint1: CGPointMake(77.79f, 56.58f) controlPoint2: CGPointMake(79.24f, 55.13f)];
    [bezierPath addLineToPoint: CGPointMake(81.04f, 55.13f)];
    [bezierPath addCurveToPoint: CGPointMake(84.28f, 58.37f) controlPoint1: CGPointMake(82.83f, 55.13f) controlPoint2: CGPointMake(84.28f, 56.58f)];
    [bezierPath addCurveToPoint: CGPointMake(81.04f, 61.61f) controlPoint1: CGPointMake(84.28f, 60.16f) controlPoint2: CGPointMake(82.83f, 61.61f)];
    [bezierPath closePath];

    [bezierPath moveToPoint: CGPointMake(132.88f, 119.69f)];
    [bezierPath addCurveToPoint: CGPointMake(131.27f, 119.26f) controlPoint1: CGPointMake(132.33f, 119.69f) controlPoint2: CGPointMake(131.78f, 119.55f)];
    [bezierPath addLineToPoint: CGPointMake(127.23f, 116.93f)];
    [bezierPath addCurveToPoint: CGPointMake(126.05f, 112.5f) controlPoint1: CGPointMake(125.68f, 116.03f) controlPoint2: CGPointMake(125.15f, 114.05f)];
    [bezierPath addCurveToPoint: CGPointMake(130.47f, 111.31f) controlPoint1: CGPointMake(126.94f, 110.95f) controlPoint2: CGPointMake(128.92f, 110.42f)];
    [bezierPath addLineToPoint: CGPointMake(134.51f, 113.64f)];
    [bezierPath addCurveToPoint: CGPointMake(135.69f, 118.07f) controlPoint1: CGPointMake(136.06f, 114.54f) controlPoint2: CGPointMake(136.59f, 116.52f)];
    [bezierPath addCurveToPoint: CGPointMake(132.88f, 119.69f) controlPoint1: CGPointMake(135.09f, 119.11f) controlPoint2: CGPointMake(134.f, 119.69f)];
    [bezierPath closePath];

    [bezierPath moveToPoint: CGPointMake(61.17f, 78.28f)];
    [bezierPath addCurveToPoint: CGPointMake(57.92f, 75.04f) controlPoint1: CGPointMake(59.38f, 78.28f) controlPoint2: CGPointMake(57.92f, 76.83f)];
    [bezierPath addCurveToPoint: CGPointMake(61.16f, 71.8f) controlPoint1: CGPointMake(57.92f, 73.25f) controlPoint2: CGPointMake(59.37f, 71.8f)];
    [bezierPath addLineToPoint: CGPointMake(61.17f, 71.8f)];
    [bezierPath addCurveToPoint: CGPointMake(64.41f, 75.04f) controlPoint1: CGPointMake(62.96f, 71.8f) controlPoint2: CGPointMake(64.41f, 73.25f)];
    [bezierPath addCurveToPoint: CGPointMake(61.17f, 78.28f) controlPoint1: CGPointMake(64.41f, 76.83f) controlPoint2: CGPointMake(62.96f, 78.28f)];
    [bezierPath closePath];

    [bezierPath moveToPoint: CGPointMake(133.63f, 90.25f)];
    [bezierPath addCurveToPoint: CGPointMake(130.44f, 87.57f) controlPoint1: CGPointMake(132.09f, 90.25f) controlPoint2: CGPointMake(130.72f, 89.14f)];
    [bezierPath addCurveToPoint: CGPointMake(133.07f, 83.82f) controlPoint1: CGPointMake(130.13f, 85.81f) controlPoint2: CGPointMake(131.31f, 84.13f)];
    [bezierPath addLineToPoint: CGPointMake(137.66f, 83.01f)];
    [bezierPath addCurveToPoint: CGPointMake(141.41f, 85.64f) controlPoint1: CGPointMake(139.42f, 82.7f) controlPoint2: CGPointMake(141.1f, 83.88f)];
    [bezierPath addCurveToPoint: CGPointMake(138.78f, 89.39f) controlPoint1: CGPointMake(141.72f, 87.4f) controlPoint2: CGPointMake(140.54f, 89.08f)];
    [bezierPath addLineToPoint: CGPointMake(134.2f, 90.2f)];
    [bezierPath addCurveToPoint: CGPointMake(133.63f, 90.25f) controlPoint1: CGPointMake(134.f, 90.23f) controlPoint2: CGPointMake(133.82f, 90.25f)];
    [bezierPath closePath];

    [bezierPath moveToPoint: CGPointMake(56.67f, 103.82f)];
    [bezierPath addCurveToPoint: CGPointMake(53.42f, 100.59f) controlPoint1: CGPointMake(54.88f, 103.82f) controlPoint2: CGPointMake(53.42f, 102.38f)];
    [bezierPath addCurveToPoint: CGPointMake(56.66f, 97.35f) controlPoint1: CGPointMake(53.42f, 98.8f) controlPoint2: CGPointMake(54.87f, 97.35f)];
    [bezierPath addLineToPoint: CGPointMake(56.67f, 97.35f)];
    [bezierPath addCurveToPoint: CGPointMake(59.9f, 100.59f) controlPoint1: CGPointMake(58.46f, 97.35f) controlPoint2: CGPointMake(59.9f, 98.8f)];
    [bezierPath addCurveToPoint: CGPointMake(56.67f, 103.82f) controlPoint1: CGPointMake(59.9f, 102.38f) controlPoint2: CGPointMake(58.45f, 103.82f)];
    [bezierPath closePath];

    [bezierPath moveToPoint: CGPointMake(119.86f, 66.41f)];
    [bezierPath addCurveToPoint: CGPointMake(117.78f, 65.65f) controlPoint1: CGPointMake(119.13f, 66.41f) controlPoint2: CGPointMake(118.39f, 66.16f)];
    [bezierPath addCurveToPoint: CGPointMake(117.39f, 61.09f) controlPoint1: CGPointMake(116.41f, 64.5f) controlPoint2: CGPointMake(116.23f, 62.46f)];
    [bezierPath addLineToPoint: CGPointMake(120.38f, 57.52f)];
    [bezierPath addCurveToPoint: CGPointMake(124.94f, 57.12f) controlPoint1: CGPointMake(121.53f, 56.15f) controlPoint2: CGPointMake(123.57f, 55.97f)];
    [bezierPath addCurveToPoint: CGPointMake(125.34f, 61.69f) controlPoint1: CGPointMake(126.32f, 58.27f) controlPoint2: CGPointMake(126.49f, 60.32f)];
    [bezierPath addLineToPoint: CGPointMake(122.35f, 65.25f)];
    [bezierPath addCurveToPoint: CGPointMake(119.86f, 66.41f) controlPoint1: CGPointMake(121.71f, 66.02f) controlPoint2: CGPointMake(120.79f, 66.41f)];
    [bezierPath closePath];

    [bezierPath moveToPoint: CGPointMake(69.63f, 126.29f)];
    [bezierPath addCurveToPoint: CGPointMake(66.39f, 123.05f) controlPoint1: CGPointMake(67.84f, 126.29f) controlPoint2: CGPointMake(66.39f, 124.84f)];
    [bezierPath addCurveToPoint: CGPointMake(69.63f, 119.81f) controlPoint1: CGPointMake(66.39f, 121.26f) controlPoint2: CGPointMake(67.84f, 119.81f)];
    [bezierPath addLineToPoint: CGPointMake(69.63f, 119.81f)];
    [bezierPath addCurveToPoint: CGPointMake(72.87f, 123.05f) controlPoint1: CGPointMake(71.42f, 119.81f) controlPoint2: CGPointMake(72.87f, 121.26f)];
    [bezierPath addCurveToPoint: CGPointMake(69.63f, 126.29f) controlPoint1: CGPointMake(72.87f, 124.84f) controlPoint2: CGPointMake(71.42f, 126.29f)];
    [bezierPath closePath];

    return bezierPath;
}
#endif

#pragma mark - Helper

- (void)updatePathWithBounds:(CGRect)bounds
{
    UIBezierPath *path = self.path.copy;

    CGFloat pathScaleW = CGRectGetWidth(bounds) / 188.f;   // to scale the icon into the view bounds
    CGFloat pathScaleH = CGRectGetHeight(bounds) / 188.f;
    CGAffineTransform scale = CGAffineTransformMakeScale(self.iconScale * pathScaleW,
                                                         self.iconScale * pathScaleH);
    CGAffineTransform translation = CGAffineTransformMakeTranslation(-(self.iconScale - 1) * (CGRectGetWidth(self.bounds) / 2.f),
                                                                     -(self.iconScale - 1) * (CGRectGetHeight(self.bounds) / 2.f));
    [path applyTransform:CGAffineTransformConcat(scale, translation)];

    self.shapeLayer.path = path.CGPath;
}

@end
