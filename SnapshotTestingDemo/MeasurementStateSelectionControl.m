//
//  MeasurementStateSelectionControl.m
//  Wheel
//
//  Created by BioWink GmbH on 11/23/12.
//  Copyright (c) 2013 BioWink GmbH. All rights reserved.
//

#import "MeasurementStateSelectionControl.h"

#import "BWMeasurementStateButton.h"
#import "BWMeasurementIconView.h"
#import "BWCrossView.h"

NSString * const MeasurementStateSelectionControlModelKeyTitle = @"MeasurementStateSelectionControlModelKeyTitle";
NSString * const MeasurementStateSelectionControlModelKeyPath = @"MeasurementStateSelectionControlModelKeyPath";
NSString * const MeasurementStateSelectionControlModelKeyAccessibilityLabel = @"MeasurementStateSelectionControlModelKeyAccessibilityLabel";

static NSInteger const ButtonTagOffset = 0x200;
static CGSize const margin = {8, 8};
static CGFloat const outerMargin = 0;


@interface MeasurementStateSelectionControl ()

@property (nonatomic, strong) UIView *grabberOverlayLeft;
@property (nonatomic, strong) UIView *grabberOverlayRight;

@property (nonatomic, copy) NSMutableArray *mSelectedIndices;

@end

@implementation MeasurementStateSelectionControl

- (id)initWithCoder:(nonnull NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _color = [UIColor cyanColor];

		_mSelectedIndices = [[NSMutableArray alloc] init];
		
        [self setUp];
    }
    return self;
}

#pragma mark - Accessors

- (void)setColor:(UIColor *)color {
    _color = color.copy;
    [self setUp];
}

- (void)setButtonParameters:(NSArray *)buttonParameters {
    _buttonParameters = buttonParameters.copy;
    [self setUp];
}

- (void)setSelectedIndices:(NSArray *)selectedIndices {
    _mSelectedIndices = selectedIndices.mutableCopy;

    for (NSInteger idx = 0; idx < 4; ++idx) {
        UIButton *button = (id) [self viewWithTag:ButtonTagOffset + idx];
        button.selected = [selectedIndices containsObject:[NSNumber numberWithInteger:(idx)]];
        if (idx == 0) [self.grabberOverlayLeft setBackgroundColor:button.selected ? [UIColor magentaColor] : [UIColor whiteColor]];
        else if (idx == 1) [self.grabberOverlayRight setBackgroundColor:button.selected ? [UIColor magentaColor] : [UIColor whiteColor]];
    }
}

#pragma mark - Ugh

- (UIButton *)buttonAtIndex:(NSUInteger)index;
{
    return (index < 4) ? (id) [self viewWithTag:ButtonTagOffset + index] : nil;
}

- (void)setUp
{
    if (nil == self.color || nil == self.buttonParameters) {
        NSLog(@"unconfigured buttons. lol bye.");
        return;
    }

    NSMutableArray *buttons = [NSMutableArray array];

    for (int count = 0; count < 4; count++) {
        UIRectCorner position = (0 == count % 2) ? UIRectCornerTopLeft : UIRectCornerTopRight;
        BWMeasurementStateButton *button = [[BWMeasurementStateButton alloc] initWithDeselectIndictorPosition:position];
        button.tag = ButtonTagOffset + count;
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [buttons addObject:button];
        [self addSubview:button];

        [button addTarget:self action:@selector(didSelectState:) forControlEvents:UIControlEventTouchUpInside];

        NSString *title = self.buttonParameters[count][MeasurementStateSelectionControlModelKeyTitle];
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:title
                                                                             attributes:@{
                                                                                          NSKernAttributeName: @1.5,
                                                                                          }];
        button.label.attributedText = attributedText;
        button.label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
        button.label.adjustsFontSizeToFitWidth = YES;
        button.label.minimumScaleFactor = 0.5f;

        button.deselectIndicator.lineCap = kCGLineCapSquare;
        button.deselectIndicator.lineWidth = 3.f;

        if (self.buttonParameters[count][MeasurementStateSelectionControlModelKeyPath]) {
            button.icon.path = self.buttonParameters[count][MeasurementStateSelectionControlModelKeyPath];
        }

        button.baseColor = [UIColor whiteColor];
        button.highlightColor = self.color;
        button.borderWidth = 7.f;

        button.enabled = YES;
        button.hidden = NO;

        button.accessibilityLabel = self.buttonParameters[count][MeasurementStateSelectionControlModelKeyAccessibilityLabel];
    }
    
    NSDictionary *views = @{@"button0" : buttons[0], @"button1" : buttons[1], @"button2" : buttons[2], @"button3" : buttons[3]};
    
    NSDictionary *metrics = @{
                              @"outerMargin": @(outerMargin),
                              @"xMargin": @(margin.width),
                              @"yMargin": @(margin.height),
                              };

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[button0]-(xMargin)-[button1]-(xMargin)-|" options:0 metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[button2]-(xMargin)-[button3]-(xMargin)-|" options:0 metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button0]-(yMargin)-[button2]" options:0 metrics:metrics views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button1]-(yMargin)-[button3]" options:0 metrics:metrics views:views]];

    for (UIView *button in buttons) {
        [self addConstraints:@[
                               [NSLayoutConstraint constraintWithItem:button
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:0
                                                               toItem:self
                                                            attribute:NSLayoutAttributeHeight
                                                           multiplier:0.5f
                                                             constant:-margin.height / 1.5f],
                               [NSLayoutConstraint constraintWithItem:button
                                                            attribute:NSLayoutAttributeWidth
                                                            relatedBy:0
                                                               toItem:self
                                                            attribute:NSLayoutAttributeWidth
                                                           multiplier:0.5f
                                                             constant:-margin.width - margin.width/2.f],
                               ]];
    }
}

- (void)didSelectState:(UIButton *)sender;
{
    NSInteger const index = sender.tag - ButtonTagOffset;
    NSAssert((0 <= index) && (index < 4), @"lol");
	
	NSNumber *indexNumber = [NSNumber numberWithInteger:index];
	
	if ([self.selectedIndices containsObject:indexNumber]) {
		[self.mSelectedIndices removeObject:indexNumber];
	}
	else {
		if (!self.allowsMultiSelect) {
			[self.mSelectedIndices removeAllObjects];
		}
		[self.mSelectedIndices addObject:indexNumber];
	}
	
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (NSArray *)selectedIndices {
    return _mSelectedIndices.copy;
}

@end
