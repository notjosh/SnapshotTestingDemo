//
//  NSLayoutConstraint+Helpers.h
//  Wheel
//
//  Created by BioWink GmbH on 12/20/12.
//  Copyright (c) 2013 BioWink GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface LayoutConstraint : NSLayoutConstraint

//+ (void)withPriority:(UILayoutPriority)priority addConstraints:(dispatch_block_t)block;

@end



@interface UIView (LayoutConstraintHelpers)

- (void)addConstraintAligningAttribute:(NSLayoutAttribute)attributeA ofView:(UIView *)viewA withAttribute:(NSLayoutAttribute)attributeB ofView:(UIView *)viewB;
- (void)addConstraintAligningAttribute:(NSLayoutAttribute)attribute ofView:(UIView *)viewA withView:(UIView *)viewB offset:(CGFloat)offset;
- (void)addConstraintAligningAttribute:(NSLayoutAttribute)attributeA ofView:(UIView *)viewA withAttribute:(NSLayoutAttribute)attributeB ofView:(UIView *)viewB offset:(CGFloat)offset;

- (void)addConstraintsForSize:(CGSize)size;
- (void)addConstraintForHeight:(CGFloat)height;
- (void)addConstraintForWidth:(CGFloat)width;
- (void)addConstraintForEqualHeightsForView:(UIView*)aView withView:(UIView*)anotherView;
- (void)addConstraintForEqualWidthsForView:(UIView*)aView withView:(UIView*)anotherView;

- (void)addConstraintsForCenteringView:(UIView *)aView withView:(UIView *)anotherView;
- (void)addConstraintForHorizontallyAligningView:(UIView *)aView withView:(UIView *)anotherView;
- (void)addConstraintForVerticallyAligningView:(UIView *)aView withView:(UIView *)otherView;
- (void)addConstraintAligningTopOfView:(UIView *)aView withTopOfView:(UIView *)otherView;
- (void)addConstraintAligningTopOfView:(UIView *)aView withBottomOfView:(UIView *)otherView;
- (void)addConstraintAligningBottomOfView:(UIView *)aView withBottomOfView:(UIView *)otherView;
- (void)addConstraintAligningBottomOfView:(UIView *)aView withTopOfView:(UIView *)otherView;

- (void)addConstraintAligningLeftOfView:(UIView *)aView withLeftOfView:(UIView *)otherView;
- (void)addConstraintAligningRightOfView:(UIView *)aView withLeftOfView:(UIView *)otherView;
- (void)addConstraintAligningRightOfView:(UIView *)aView withRightOfView:(UIView *)otherView;

- (void)addConstraintsForContainerHugging;
- (void)addConstraintsForContainerHuggingHorizontally;
- (void)addConstraintsForContainerHuggingVertically;
- (void)addConstraintForCenteringHorizontally;
- (void)addConstraintForCenteringVertically;
- (void)addConstraintsForContainerTopLeftAlignment;

- (void)addConstraintsForContainerInsets:(UIEdgeInsets)insets;

- (void)setContentCompressionResistanceAndHuggingPriority:(UILayoutPriority)priority;

- (void)addConstraintForVerticalMargin:(CGFloat)margin betweenView:(UIView *)topView andView:(UIView *)bottomView;
- (void)addConstraintForHorizontalMargin:(CGFloat)margin betweenView:(UIView *)leftView andView:(UIView *)rightView;

- (void)addConstraintsForLeftBottomMargins:(CGSize)margins;
- (void)addConstraintsForRightBottomMargins:(CGSize)margins;

- (void)addConstraintForMargins:(UIEdgeInsets)margins;
- (void)addConstraintForLeftMargin:(CGFloat)margin;
- (NSLayoutConstraint *)addConstraintForRightMargin:(CGFloat)margin;
- (void)addConstraintsForLeftAndRightMargin:(CGFloat)margin;
- (NSLayoutConstraint *)addConstraintForTopMargin:(CGFloat)margin;
- (NSLayoutConstraint *)addConstraintForBottomMargin:(CGFloat)margin;

- (void)addConstraintsForCenteringOnLeftBottomPosition:(CGPoint)margins;
- (void)addConstraintsForCenteringOnRightBottomPosition:(CGPoint)margins;

@end



@interface UIButton (LayoutConstraintHelpers)

- (void)addConstraintsForSizeByUsingImageAlignmentRect;

@end
