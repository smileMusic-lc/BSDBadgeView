//
//  UIView+BSDBadgeView.m
//  instalment
//
//  Created by 梁策 on 2019/12/19.
//  Copyright © 2019 BSD. All rights reserved.
//

#import "UIView+BSDBadgeView.h"
#import "BSDBadgeControl.h"
#import <objc/runtime.h>

static NSString *const kBadgeView = @"kBadgeView";

@interface UIView ()

@end

@implementation UIView (BSDBadgeView)

- (void)bsd_addBadgeWithText:(NSString *)text
{
    if (text == nil ||text.length == 0 ) {
        [self bsd_hiddenBadge];
        return;
    }
    [self bsd_showBadge];
    if ([text isEqualToString:@"yuanDian"]) {
        self.badgeView.text = @"";
        [self bsd_setBadgeHeight:10];
    }else{
       self.badgeView.text = text;
       [self bsd_setBadgeHeight:16];
       self.badgeView.backgroundColor =  [UIColor colorWithRed:99/255.0 green:20/255.0 blue:32/255.0 alpha:1];
    }
    [self bsd_setBadgeFlexMode:self.badgeView.flexMode];
    if (text) {
        if (self.badgeView.widthConstraint && self.badgeView.widthConstraint.relation == NSLayoutRelationGreaterThanOrEqual) { return; }
        self.badgeView.widthConstraint.active = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.badgeView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
        [self.badgeView addConstraint:constraint];
    } else {
        if (self.badgeView.widthConstraint && self.badgeView.widthConstraint.relation == NSLayoutRelationEqual) { return; }
        self.badgeView.widthConstraint.active = NO;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.badgeView attribute:(NSLayoutAttributeHeight) multiplier:1.0 constant:0];
        [self.badgeView addConstraint:constraint];
    }
}

- (void)bsd_addBadgeWithNumber:(NSInteger)number
{
    if (number <= 0) {
        [self bsd_addBadgeWithText:@"0"];
        [self bsd_hiddenBadge];
        return;
    }else if (number > 99){
         [self bsd_addBadgeWithText:@"99+"];
    }else{
        [self bsd_addBadgeWithText:[NSString stringWithFormat:@"%ld",(long)number]];
    }
}

- (void)bsd_addDotWithColor:(UIColor *)color
{
    [self bsd_addBadgeWithText:@"yuanDian"];
    self.badgeView.backgroundColor = color;
}

- (void)bsd_moveBadgeWithX:(CGFloat)x Y:(CGFloat)y
{
    self.badgeView.offset = CGPointMake(x, y);
    [self centerYConstraintWithItem:self.badgeView].constant = y;
    
    CGFloat badgeHeight = self.badgeView.heightConstraint.constant;
    switch (self.badgeView.flexMode) {
        case BSDBadgeViewFlexModeHead: // 1. 左伸缩  <==●
        {
            [self centerXConstraintWithItem:self.badgeView].active = NO;
            [self leadingConstraintWithItem:self.badgeView].active = NO;
            if ([self trailingConstraintWithItem:self.badgeView]) {
                [self trailingConstraintWithItem:self.badgeView].constant = x + badgeHeight*0.5;
                return;
            }
            NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeTrailing relatedBy:(NSLayoutRelationEqual) toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:(x + badgeHeight*0.5)];
            [self addConstraint:trailingConstraint];
            break;
        }
        case BSDBadgeViewFlexModeTail: // 2. 右伸缩 ●==>
        {
            [self centerXConstraintWithItem:self.badgeView].active = NO;
            [self trailingConstraintWithItem:self.badgeView].active = NO;
            if ([self leadingConstraintWithItem:self.badgeView]) {
                [self leadingConstraintWithItem:self.badgeView].constant = x - badgeHeight*0.5;
                return;
            }
            NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:(x - badgeHeight*0.5)];
            [self addConstraint:leadingConstraint];
            break;
        }
        case BSDBadgeViewFlexModeMiddle: // 3. 左右伸缩  <=●=>
        {
            [self leadingConstraintWithItem:self.badgeView].active = NO;
            [self trailingConstraintWithItem:self.badgeView].active = NO;
            if ([self centerXConstraintWithItem:self.badgeView]) {
                [self centerXConstraintWithItem:self.badgeView].constant = x;
                return;
            }
            NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:x];
            [self addConstraint:centerXConstraint];
            break;
        }
    }
}

- (void)bsd_setBadgeFlexMode:(BSDBadgeViewFlexMode)flexMode
{
    self.badgeView.flexMode = flexMode;
    [self bsd_moveBadgeWithX:self.badgeView.offset.x Y:self.badgeView.offset.y];
}
- (void)bsd_setBadgeBorderWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    self.badgeView.layer.borderWidth = borderWidth;
    self.badgeView.layer.borderColor = borderColor.CGColor;
}
- (void)bsd_setBadgeHeight:(CGFloat)height
{
    self.badgeView.layer.cornerRadius = height * 0.5;
    self.badgeView.heightConstraint.constant = height;
    [self bsd_moveBadgeWithX:self.badgeView.offset.x Y:self.badgeView.offset.y];
}

- (void)bsd_showBadge
{
    self.badgeView.hidden = NO;
}

- (void)bsd_hiddenBadge
{
    self.badgeView.hidden = YES;
}

- (void)bsd_increase
{
    [self bsd_increaseBy:1];
}

- (void)bsd_increaseBy:(NSInteger)number
{
    NSInteger result = self.badgeView.text.integerValue + number;
    if (result > 0) {
        [self bsd_showBadge];
    }
    self.badgeView.text = [NSString stringWithFormat:@"%ld",(long)result];
}

- (void)bsd_decrease
{
    [self bsd_decreaseBy:1];
}

- (void)bsd_decreaseBy:(NSInteger)number
{
    NSInteger result = self.badgeView.text.integerValue - number;
    if (result <= 0) {
        [self bsd_hiddenBadge];
        self.badgeView.text = @"0";
        return;
    }
    self.badgeView.text = [NSString stringWithFormat:@"%ld",(long)result];
}

- (void)addBadgeViewLayoutConstraint
{
    [self.badgeView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.badgeView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.badgeView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:15];
    [self addConstraints:@[centerXConstraint, centerYConstraint]];
    [self.badgeView addConstraints:@[widthConstraint, heightConstraint]];
}

#pragma mark - setter/getter

- (BSDBadgeControl *)badgeView
{
    BSDBadgeControl *badgeView = objc_getAssociatedObject(self, &kBadgeView);
    if (!badgeView) {
        badgeView = [BSDBadgeControl defaultBadge];
        [self addSubview:badgeView];
        [self bringSubviewToFront:badgeView];
        [self setBadgeView:badgeView];
        [self addBadgeViewLayoutConstraint];
    }
    return badgeView;
}

- (void)setBadgeView:(BSDBadgeControl *)badgeView
{
    objc_setAssociatedObject(self, &kBadgeView, badgeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

#pragma mark -------------------------------

@implementation UIView (Constraint)

- (NSLayoutConstraint *)widthConstraint
{
    return [self constraint:self attribute:NSLayoutAttributeWidth];
}

- (NSLayoutConstraint *)heightConstraint
{
    return [self constraint:self attribute:NSLayoutAttributeHeight];
}

- (NSLayoutConstraint *)topConstraintWithItem: (id)item
{
    return [self constraint:item attribute:NSLayoutAttributeTop];
}

- (NSLayoutConstraint *)leadingConstraintWithItem: (id)item
{
    return [self constraint:item attribute:NSLayoutAttributeLeading];
}

- (NSLayoutConstraint *)bottomConstraintWithItem:(id)item
{
    return [self constraint:item attribute:NSLayoutAttributeBottom];
}

- (NSLayoutConstraint *)trailingConstraintWithItem:(id)item
{
    return [self constraint:item attribute:NSLayoutAttributeTrailing];
}

- (NSLayoutConstraint *)centerXConstraintWithItem:(id)item
{
    return [self constraint:item attribute:NSLayoutAttributeCenterX];
}

- (NSLayoutConstraint *)centerYConstraintWithItem:(id)item
{
    return [self constraint:item attribute:NSLayoutAttributeCenterY];
}

- (NSLayoutConstraint *)constraint:(id)item attribute: (NSLayoutAttribute)layoutAttribute
{
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstItem == item && constraint.firstAttribute == layoutAttribute) {
            return constraint;
        }
    }
    return nil;
}

@end
