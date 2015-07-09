//
//  NSLayoutConstraint+Helpers.m
//  Wheel
//
//  Created by BioWink GmbH on 12/20/12.
//  Copyright (c) 2013 BioWink GmbH. All rights reserved.
//

#import "NSLayoutConstraint+Helpers.h"

#import "Geometry.h"

//#define DEBUG_CONTRAINTS_ENABLED

#ifdef DEBUG_CONTRAINTS_ENABLED
static SEL currentMethod;
class ConstraintDebugger {
public:
    ConstraintDebugger(SEL selector, UIView *view) : _active(currentMethod == NULL), _view((currentMethod == NULL) ? view : nil), _initialConstraints((currentMethod == NULL) ? [NSSet setWithArray:[_view constraints]] : nil) {
        if (_active) {
            currentMethod = selector;
            if (_view == nil) {
                NSString *output = [NSString stringWithFormat:@"WARNING: view is nil inside %@", NSStringFromSelector(currentMethod)];
                fprintf(stderr, "%s\n", [output UTF8String]);
            }
        }
    };
    ~ConstraintDebugger(void) { if (_active) {
        NSMutableSet *newConstraints = [NSMutableSet setWithArray:[_view constraints]];
        [newConstraints minusSet:_initialConstraints];
        NSMutableString *output = [NSMutableString stringWithFormat:@"New constraints for view %p added by %@\n", _view, NSStringFromSelector(currentMethod)];
        for (NSLayoutConstraint *c in newConstraints) {
            [output appendFormat:@"\t%@\n", c];
        }
        fprintf(stderr, "%s", [output UTF8String]);
        currentMethod = NULL;
    }};
    BOOL const _active;
    __strong UIView *_view;
    __strong NSSet *_initialConstraints;
};
# define DebugContraints(view) ConstraintDebugger constraintDebugger(_cmd, view);
#else
# define DebugContraints(view)
#endif


@implementation LayoutConstraint

+ (id)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(id)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c
{
    LayoutConstraint *result = [super constraintWithItem:view1 attribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 multiplier:multiplier constant:c];
    result.priority = 500;
    return result;
}

+ (NSArray *)constraintsWithVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)opts metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    NSArray *result = [super constraintsWithVisualFormat:format options:opts metrics:metrics views:views];
    for (NSLayoutConstraint *constraint in result) {
        constraint.priority = 500;
    }
    return result;
}

@end



@implementation UIView (LayoutConstraintHelpers)

- (void)addConstraintAligningAttribute:(NSLayoutAttribute)attributeA ofView:(UIView *)viewA withAttribute:(NSLayoutAttribute)attributeB ofView:(UIView *)viewB;
{
    DebugContraints(self);
    [self addConstraint:[LayoutConstraint constraintWithItem:viewA attribute:attributeA relatedBy:NSLayoutRelationEqual toItem:viewB attribute:attributeB multiplier:1 constant:0]];
}

- (void)addConstraintAligningAttribute:(NSLayoutAttribute)attribute ofView:(UIView *)viewA withView:(UIView *)viewB offset:(CGFloat)offset;
{
    DebugContraints(self);
    [self addConstraint:[LayoutConstraint constraintWithItem:viewA attribute:attribute relatedBy:NSLayoutRelationEqual toItem:viewB attribute:attribute multiplier:1 constant:offset]];
}

- (void)addConstraintAligningAttribute:(NSLayoutAttribute)attributeA ofView:(UIView *)viewA withAttribute:(NSLayoutAttribute)attributeB ofView:(UIView *)viewB offset:(CGFloat)offset;
{
    DebugContraints(self);
    [self addConstraint:[LayoutConstraint constraintWithItem:viewA attribute:attributeA relatedBy:NSLayoutRelationEqual toItem:viewB attribute:attributeB multiplier:1 constant:offset]];
}

- (void)addConstraintsForSize:(CGSize)size;
{
    DebugContraints(self);
    [self addConstraintForWidth:size.width];
    [self addConstraintForHeight:size.height];
}

- (void)addConstraintForWidth:(CGFloat)width;
{
    DebugContraints(self);
    [self addConstraint:[LayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:width]];
}

- (void)addConstraintForEqualWidthsForView:(UIView*)aView withView:(UIView*)anotherView {
	
    DebugContraints(self);
    [self addConstraintAligningAttribute:NSLayoutAttributeWidth ofView:aView withAttribute:NSLayoutAttributeWidth ofView:anotherView];
}

- (void)addConstraintForHeight:(CGFloat)height;
{
    DebugContraints(self);
    [self addConstraint:[LayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:height]];
}

- (void)addConstraintForEqualHeightsForView:(UIView*)aView withView:(UIView*)anotherView {
	
    DebugContraints(self);
    [self addConstraintAligningAttribute:NSLayoutAttributeHeight ofView:aView withAttribute:NSLayoutAttributeHeight ofView:anotherView];
}

- (void)addConstraintsForCenteringView:(UIView *)aView withView:(UIView *)anotherView;
{
    DebugContraints(self);
    [self addConstraintForHorizontallyAligningView:aView withView:anotherView];
    [self addConstraintForVerticallyAligningView:aView withView:anotherView];
}

- (void)addConstraintForHorizontallyAligningView:(UIView *)aView withView:(UIView *)otherView;
{
    DebugContraints(self);
    [self addConstraintAligningAttribute:NSLayoutAttributeCenterX ofView:aView withAttribute:NSLayoutAttributeCenterX ofView:otherView];
}

- (void)addConstraintForVerticallyAligningView:(UIView *)aView withView:(UIView *)otherView;
{
    DebugContraints(self);
    [self addConstraintAligningAttribute:NSLayoutAttributeCenterY ofView:aView withAttribute:NSLayoutAttributeCenterY ofView:otherView];
}

- (void)addConstraintAligningTopOfView:(UIView *)aView withTopOfView:(UIView *)otherView;
{
    DebugContraints(self);
    [self addConstraintAligningAttribute:NSLayoutAttributeTop ofView:aView withAttribute:NSLayoutAttributeTop ofView:otherView];
}

- (void)addConstraintAligningTopOfView:(UIView *)aView withBottomOfView:(UIView *)otherView;
{
    DebugContraints(self);
    [self addConstraintAligningAttribute:NSLayoutAttributeTop ofView:aView withAttribute:NSLayoutAttributeBottom ofView:otherView];
}

- (void)addConstraintAligningBottomOfView:(UIView *)aView withBottomOfView:(UIView *)otherView;
{
    DebugContraints(self);
    [self addConstraintAligningAttribute:NSLayoutAttributeBottom ofView:aView withAttribute:NSLayoutAttributeBottom ofView:otherView];
}

- (void)addConstraintAligningBottomOfView:(UIView *)aView withTopOfView:(UIView *)otherView;
{
    DebugContraints(self);
    [self addConstraintAligningAttribute:NSLayoutAttributeBottom ofView:aView withAttribute:NSLayoutAttributeTop ofView:otherView];
}

- (void)addConstraintAligningLeftOfView:(UIView *)aView withLeftOfView:(UIView *)otherView;
{
    DebugContraints(self);
    [self addConstraintAligningAttribute:NSLayoutAttributeLeft ofView:aView withAttribute:NSLayoutAttributeLeft ofView:otherView];
}

- (void)addConstraintAligningRightOfView:(UIView *)aView withLeftOfView:(UIView *)otherView;
{
    DebugContraints(self);
    [self addConstraintAligningAttribute:NSLayoutAttributeRight ofView:aView withAttribute:NSLayoutAttributeLeft ofView:otherView];
}

- (void)addConstraintAligningRightOfView:(UIView *)aView withRightOfView:(UIView *)otherView;
{
    DebugContraints(self);
    [self addConstraintAligningAttribute:NSLayoutAttributeRight ofView:aView withAttribute:NSLayoutAttributeRight ofView:otherView];
}

- (void)addConstraintsForContainerHugging;
{
    DebugContraints(self.superview);
    [self addConstraintsForContainerHuggingHorizontally];
    [self addConstraintsForContainerHuggingVertically];
}

- (void)addConstraintsForContainerHuggingHorizontally;
{
    UIView *superview = self.superview;
    DebugContraints(superview);
    [superview addConstraintAligningAttribute:NSLayoutAttributeCenterX ofView:self withAttribute:NSLayoutAttributeCenterX ofView:superview];
    [superview addConstraintAligningAttribute:NSLayoutAttributeWidth ofView:self withAttribute:NSLayoutAttributeWidth ofView:superview];
}

- (void)addConstraintsForContainerHuggingVertically;
{
    UIView *superview = self.superview;
    DebugContraints(superview);
    [superview addConstraintAligningAttribute:NSLayoutAttributeCenterY ofView:self withAttribute:NSLayoutAttributeCenterY ofView:superview];
    [superview addConstraintAligningAttribute:NSLayoutAttributeHeight ofView:self withAttribute:NSLayoutAttributeHeight ofView:superview];
}


- (void)addConstraintsForContainerTopLeftAlignment;
{
    UIView *superview = self.superview;
    DebugContraints(superview);
    [superview addConstraintAligningAttribute:NSLayoutAttributeLeading ofView:self withView:superview offset:0];
    [superview addConstraintAligningAttribute:NSLayoutAttributeTop ofView:self withView:superview offset:0];
}

- (void)addConstraintForCenteringHorizontally;
{
    UIView *superview = self.superview;
    DebugContraints(superview);
    [superview addConstraintAligningAttribute:NSLayoutAttributeCenterX ofView:self withAttribute:NSLayoutAttributeCenterX ofView:superview];
}

- (void)addConstraintForCenteringVertically;
{
    UIView *superview = self.superview;
    DebugContraints(superview);
    [superview addConstraintAligningAttribute:NSLayoutAttributeCenterY ofView:self withAttribute:NSLayoutAttributeCenterY ofView:superview];
}

- (void)addConstraintsForContainerInsets:(UIEdgeInsets)insets;
{
    UIView *superview = self.superview;
    DebugContraints(superview);
    [superview addConstraintAligningAttribute:NSLayoutAttributeTop ofView:self withView:superview offset:insets.top];
    [superview addConstraintAligningAttribute:NSLayoutAttributeLeft ofView:self withView:superview offset:insets.left];
    [superview addConstraintAligningAttribute:NSLayoutAttributeBottom ofView:self withView:superview offset:-insets.bottom];
    [superview addConstraintAligningAttribute:NSLayoutAttributeRight ofView:self withView:superview offset:-insets.right];
}

- (void)setContentCompressionResistanceAndHuggingPriority:(UILayoutPriority)priority;
{
    [self setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisHorizontal];
    [self setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisVertical];
    [self setContentCompressionResistancePriority:priority forAxis:UILayoutConstraintAxisHorizontal];
    [self setContentCompressionResistancePriority:priority forAxis:UILayoutConstraintAxisVertical];
}

- (void)addConstraintForVerticalMargin:(CGFloat)margin betweenView:(UIView *)topView andView:(UIView *)bottomView;
{
    DebugContraints(self);
    [self addConstraint:[LayoutConstraint constraintWithItem:bottomView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:topView attribute:NSLayoutAttributeBottom multiplier:1 constant:margin]];
}

- (void)addConstraintForHorizontalMargin:(CGFloat)margin betweenView:(UIView *)leftView andView:(UIView *)rightView;
{
    DebugContraints(self);
    [self addConstraint:[LayoutConstraint constraintWithItem:rightView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:leftView attribute:NSLayoutAttributeRight multiplier:1 constant:margin]];
}

- (void)addConstraintsForLeftBottomMargins:(CGSize)margins;
{
    UIView *superview = self.superview;
    DebugContraints(superview);
    [superview addConstraintAligningAttribute:NSLayoutAttributeLeft ofView:self withView:superview offset:margins.width];
    [superview addConstraintAligningAttribute:NSLayoutAttributeBottom ofView:self withView:superview offset:-margins.height];
}

- (void)addConstraintsForRightBottomMargins:(CGSize)margins;
{
    UIView *superview = self.superview;
    DebugContraints(superview);
    [superview addConstraintAligningAttribute:NSLayoutAttributeRight ofView:self withView:superview offset:-margins.width];
    [superview addConstraintAligningAttribute:NSLayoutAttributeBottom ofView:self withView:superview offset:-margins.height];
}

- (void)addConstraintForLeftMargin:(CGFloat)margin;
{
    UIView *superview = self.superview;
    DebugContraints(superview);
    [superview addConstraint:[LayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeLeft multiplier:1 constant:margin]];
}

- (NSLayoutConstraint *)addConstraintForRightMargin:(CGFloat)margin;
{
    UIView *superview = self.superview;
    DebugContraints(superview);
    NSLayoutConstraint *c = [LayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeRight multiplier:1 constant:-margin];
    [superview addConstraint:c];
    return c;
}

- (void)addConstraintsForLeftAndRightMargin:(CGFloat)margin;
{
    UIView *superview = self.superview;
    DebugContraints(superview);
    NSLayoutConstraint *c = [LayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeLeft multiplier:1 constant:margin];
    [superview addConstraint:c];
    c = [LayoutConstraint constraintWithItem:superview attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:margin];
    [superview addConstraint:c];
}

- (void)addConstraintForMargins:(UIEdgeInsets)margins;
{
    UIView *superview = self.superview;
    DebugContraints(superview);
    [superview addConstraint:[LayoutConstraint constraintWithItem:self      attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeLeft multiplier:1 constant:margins.left]];
    [superview addConstraint:[LayoutConstraint constraintWithItem:superview attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:margins.right]];
    [superview addConstraint:[LayoutConstraint constraintWithItem:self      attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeTop multiplier:1 constant:margins.top]];
    [superview addConstraint:[LayoutConstraint constraintWithItem:superview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:margins.bottom]];
}

- (NSLayoutConstraint *)addConstraintForBottomMargin:(CGFloat)margin;
{
    UIView *superview = self.superview;
    DebugContraints(superview);
    NSLayoutConstraint *c = [LayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeBottom multiplier:1 constant:-margin];
    [superview addConstraint:c];
    return c;
}

- (NSLayoutConstraint *)addConstraintForTopMargin:(CGFloat)margin;
{
    UIView *superview = self.superview;
    DebugContraints(superview);
    NSLayoutConstraint *c = [LayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeTop multiplier:1 constant:margin];
    [superview addConstraint:c];
    return c;
}

- (void)addConstraintsForCenteringOnLeftBottomPosition:(CGPoint)margins;
{
    UIView *superview = self.superview;
    DebugContraints(superview);
    [superview addConstraint:[LayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeLeft multiplier:1 constant:margins.x]];
    [superview addConstraint:[LayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeBottom multiplier:1 constant:-margins.y]];
}

- (void)addConstraintsForCenteringOnRightBottomPosition:(CGPoint)margins;
{
    UIView *superview = self.superview;
    DebugContraints(superview);
    [superview addConstraint:[LayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeRight multiplier:1 constant:-margins.x]];
    [superview addConstraint:[LayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeBottom multiplier:1 constant:-margins.y]];
}

@end



@implementation UIButton (LayoutConstraintHelpers)

- (void)addConstraintsForSizeByUsingImageAlignmentRect;
{
    DebugContraints(self);
    UIImage *image = self.currentImage;
    NSAssert(image != nil, @"lol");
    UIEdgeInsets ei = image.alignmentRectInsets;
    [self addConstraintsForSize:SizeByInsettingSize(image.size, ei)];
    self.imageEdgeInsets = UIEdgeInsetsMake(-ei.top, -ei.left, -ei.bottom, -ei.right);
}

@end
