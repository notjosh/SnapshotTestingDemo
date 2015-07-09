//
//  BWMeasurementStateButton.m
//  Wheel
//
//  Created by joshua may on 12/11/2014.
//  Copyright (c) 2014 BioWink GmbH. All rights reserved.
//

#import "BWMeasurementStateButton.h"

#import "NSLayoutConstraint+Helpers.h"

#import "BWCrossView.h"
#import "BWMeasurementIconView.h"

@interface BWMeasurementStateButton ()

@property (nonatomic, strong, readwrite) UILabel *label;
@property (nonatomic, strong, readwrite) BWMeasurementIconView *icon;

@property (nonatomic, strong) UIView *iconContainer;

@property (nonatomic, assign, getter=isInited) BOOL inited;

@end

@implementation BWMeasurementStateButton

- (void)setLabelText:(NSString *)labelText {
    _labelText = labelText.copy;
    
    self.label.text = labelText;
}

- (void)setDeselectIndicatorVisible:(BOOL)deselectIndicatorVisible {
    self.deselectIndicator.hidden = !deselectIndicatorVisible;
}






- (instancetype)init
{
    return [self initWithDeselectIndictorPosition:UIRectCornerTopRight];
}

- (instancetype)initWithCoder:(nonnull NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self commonInitWithDeselectIndictorPosition:UIRectCornerTopRight];
    }

    return self;
}

#if TARGET_INTERFACE_BUILDER
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        [self commonInitWithDeselectIndictorPosition:UIRectCornerTopRight];
    }

    return self;
}
#endif

- (instancetype)initWithDeselectIndictorPosition:(UIRectCorner)deselectIndictorPosition
{
    self = [super init];

    if (self) {
        [self commonInitWithDeselectIndictorPosition:deselectIndictorPosition];
    }

    return self;
}

- (void)commonInitWithDeselectIndictorPosition:(UIRectCorner)deselectIndictorPosition {
    if (self.isInited) {
        return;
    }

    self.inited = YES;

    _label = [[UILabel alloc] init];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.translatesAutoresizingMaskIntoConstraints = NO;

    _deselectIndicator = [[BWCrossView alloc] init];
    _deselectIndicator.translatesAutoresizingMaskIntoConstraints = NO;

    _icon = [[BWMeasurementIconView alloc] init];
    _icon.translatesAutoresizingMaskIntoConstraints = NO;
    _icon.iconScale = 1.2f;

    _iconContainer = [[UIView alloc] init];
    _iconContainer.translatesAutoresizingMaskIntoConstraints = NO;

    _label.userInteractionEnabled = NO;
    _icon.userInteractionEnabled = NO;
    _iconContainer.userInteractionEnabled = NO;
    _deselectIndicator.userInteractionEnabled = NO;

    [self addSubview:_label];
    [self addSubview:_iconContainer];
    [self addSubview:_deselectIndicator];

    [_iconContainer addSubview:_icon];

    [_label addConstraintsForLeftAndRightMargin:12.f];
    [_iconContainer addConstraintForCenteringHorizontally];
    [_deselectIndicator addConstraintsForSize:CGSizeMake(10.f, 10.f)];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[_iconContainer]-0-[_label]-8-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_iconContainer, _label)]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-12-[_iconContainer]-12-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_iconContainer)]];

    // deselect indicator position
    CGFloat deselectIndicatorPadding = 10.f;

    NSString *formatH;
    NSString *formatV;

    if (UIRectCornerTopLeft == deselectIndictorPosition ||
        UIRectCornerTopRight == deselectIndictorPosition) {
        formatV = @"V:|-(padding)-[_deselectIndicator]";
    } else {
        formatV = @"V:[_deselectIndicator]-(padding)-|";
    }

    if (UIRectCornerTopRight == deselectIndictorPosition ||
        UIRectCornerBottomRight == deselectIndictorPosition) {
        formatH = @"H:[_deselectIndicator]-(padding)-|";
    } else {
        formatH = @"H:|-(padding)-[_deselectIndicator]";
    }

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatH
                                                                 options:0
                                                                 metrics:@{ @"padding": @(deselectIndicatorPadding), }
                                                                   views:NSDictionaryOfVariableBindings(_deselectIndicator)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatV
                                                                 options:0
                                                                 metrics:@{ @"padding": @(deselectIndicatorPadding), }
                                                                   views:NSDictionaryOfVariableBindings(_deselectIndicator)]];

    // aspect ratio
    [_icon addConstraint:[NSLayoutConstraint constraintWithItem:_icon
                                                      attribute:NSLayoutAttributeWidth
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:_icon
                                                      attribute:NSLayoutAttributeHeight
                                                     multiplier:1.f
                                                       constant:0.f]];

    [_iconContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_icon]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:NSDictionaryOfVariableBindings(_icon)]];
    [_iconContainer addConstraint:[NSLayoutConstraint constraintWithItem:_icon
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:_iconContainer
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1.f
                                                                constant:0.f]];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.deselectIndicator.hidden = YES;
    });
    _deselectIndicator.hidden = YES;

}

#pragma mark - Override

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];

    [self updateColors];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];

    [self updateColors];
}

#pragma mark - API

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;

    self.layer.borderWidth = borderWidth;
}

- (void)setBaseColor:(UIColor *)baseColor
{
    _baseColor = baseColor;

    [self updateColors];
}

- (void)setHighlightColor:(UIColor *)highlightColor
{
    _highlightColor = highlightColor;

    self.layer.borderColor = highlightColor.CGColor;

    [self updateColors];
}

#pragma mark - Helper

- (void)updateColors
{
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue
                     forKey:kCATransactionDisableActions];

    if (self.isSelected || self.isHighlighted) {
        self.backgroundColor = self.highlightColor;
        self.label.textColor = self.baseColor;
        self.icon.shapeLayer.fillColor = self.baseColor.CGColor;
        self.icon.shapeLayer.strokeColor = self.baseColor.CGColor;
        self.deselectIndicator.hidden = NO;
    } else {
        self.backgroundColor = self.baseColor;
        self.label.textColor = self.highlightColor;
        self.icon.shapeLayer.fillColor = self.highlightColor.CGColor;
        self.icon.shapeLayer.strokeColor = self.highlightColor.CGColor;
        self.deselectIndicator.hidden = YES;
    }

    self.deselectIndicator.backgroundColor = self.highlightColor;
    self.deselectIndicator.color = self.baseColor;

    [CATransaction commit];
}

@end
