//
//  BWCrossView.m
//  Wheel
//
//  Created by joshua may on 13/11/2014.
//  Copyright (c) 2014 BioWink GmbH. All rights reserved.
//

#import "BWCrossView.h"

@implementation BWCrossView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lineCap = kCGLineCapSquare;
        _lineWidth = 1.f;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (nil == self.color) {
        return;
    }

    CGRect targetRect = CGRectInset(self.bounds, self.lineWidth, self.lineWidth);

    [self.color set];

    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGContextSetLineCap(UIGraphicsGetCurrentContext(), self.lineCap);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.lineWidth);

    CGContextMoveToPoint(ctx, CGRectGetMinX(targetRect), CGRectGetMinY(targetRect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(targetRect), CGRectGetMaxY(targetRect));

    CGContextMoveToPoint(ctx, CGRectGetMinX(targetRect), CGRectGetMaxY(targetRect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(targetRect), CGRectGetMinY(targetRect));

    CGContextStrokePath(ctx);
}

#pragma mark - API

- (void)setColor:(UIColor *)color
{
    if ([_color isEqual:color]) {
        return;
    }

    _color = color.copy;

    [self setNeedsDisplay];
}

- (void)setLineCap:(CGLineCap)lineCap
{
    if (_lineCap == lineCap) {
        return;
    }

    _lineCap = lineCap;

    [self setNeedsDisplay];
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    if (_lineWidth == lineWidth) {
        return;
    }

    _lineWidth = lineWidth;

    [self setNeedsDisplay];
}

@end
