//
//  Geometry.m
//  Wheel
//
//  Created by BioWink GmbH on 1/28/13.
//  Copyright (c) 2013 BioWink GmbH. All rights reserved.
//

#import "Geometry.h"

CGPoint PointOnCircle(CGFloat const angle, CGFloat const radius, CGPoint const center)
{
    return CGPointMake(center.x + cos(angle) * radius,
                       center.y + sin(angle) * radius);
}

CGFloat AngleFromPointOnCircle(CGPoint const p, CGPoint const center)
{
    return (CGFloat)M_PI_2 - atan2(p.x - center.x, p.y - center.y);
}

CGFloat roundToHalf(CGFloat const f)
{
    return 0.5f * round(f * 2.f);
}