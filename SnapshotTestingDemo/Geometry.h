//
//  Geometry.h
//  Wheel
//
//  Created by BioWink GmbH on 1/28/13.
//  Copyright (c) 2013 BioWink GmbH. All rights reserved.
//

@import UIKit;

static inline CGRect UIEdgeInsetsOutsetRect(CGRect r, UIEdgeInsets ei)
{
    return UIEdgeInsetsInsetRect(r, UIEdgeInsetsMake(-ei.top, -ei.left, -ei.bottom, -ei.right));
}

static inline CGSize SizeByInsettingSize(CGSize s, UIEdgeInsets ei)
{
    return CGSizeMake(s.width - ei.left - ei.right, s.height - ei.top - ei.bottom);
}

static inline CGSize SizeByOutsettingSize(CGSize s, UIEdgeInsets ei)
{
    return CGSizeMake(s.width + ei.left + ei.right, s.height + ei.top + ei.bottom);
}

static inline CGRect RectWithCenterAndRadius(CGPoint c, CGFloat r)
{
    return CGRectMake(c.x - r, c.y - r, 2.f * r, 2.f * r);
}

extern CGPoint PointOnCircle(CGFloat const angle, CGFloat const radius, CGPoint const center);

extern CGFloat AngleFromPointOnCircle(CGPoint const p, CGPoint const center);

extern CGFloat roundToHalf(CGFloat const f);

static inline CGRect HalfPixelRect(CGRect r)
{
    r.origin.x *= 2.f;
    r.origin.y *= 2.f;
    r.size.width *= 2.f;
    r.size.height *= 2.f;
    r = CGRectIntegral(r);
    r.origin.x *= 0.5f;
    r.origin.y *= 0.5f;
    r.size.width *= 0.5f;
    r.size.height *= 0.5f;
    return r;
}
