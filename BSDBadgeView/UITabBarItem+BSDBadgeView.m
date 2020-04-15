//
//  UITabBarItem+BSDBadgeView.m
//  instalment
//
//  Created by 梁策 on 2019/12/19.
//  Copyright © 2019 BSD. All rights reserved.
//

#import "UITabBarItem+BSDBadgeView.h"
#import "UIView+BSDBadgeView.h"

@implementation UITabBarItem (BSDBadgeView)

- (BSDBadgeControl *)badgeView
{
    return [self bottomView].badgeView;
}

- (void)bsd_addBadgeWithText:(NSString *)text
{
    [[self bottomView] bsd_addBadgeWithText:text];
    [[self bottomView] bsd_moveBadgeWithX:4 Y:3]; // 默认为系统badge所在的位置
}

- (void)bsd_addBadgeWithNumber:(NSInteger)number
{
    [[self bottomView] bsd_addBadgeWithNumber:number];
    [[self bottomView] bsd_moveBadgeWithX:4 Y:3];
}

- (void)bsd_addDotWithColor:(UIColor *)color
{
    [[self bottomView] bsd_addDotWithColor:color];
}
- (void)bsd_setBadgeBorderWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    [[self bottomView] bsd_setBadgeBorderWithBorderColor:borderColor borderWidth:borderWidth];
}
- (void)bsd_setBadgeHeight:(CGFloat)height
{
    [[self bottomView] bsd_setBadgeHeight:height];
}

- (void)bsd_setBadgeFlexMode:(BSDBadgeViewFlexMode)flexMode
{
    [[self bottomView] bsd_setBadgeFlexMode:flexMode];
}

- (void)bsd_moveBadgeWithX:(CGFloat)x Y:(CGFloat)y
{
    [[self bottomView] bsd_moveBadgeWithX:x Y:y];
}

- (void)bsd_showBadge
{
    [[self bottomView] bsd_showBadge];
}

- (void)bsd_hiddenBadge
{
    [[self bottomView] bsd_hiddenBadge];
}

- (void)bsd_increase
{
    [[self bottomView] bsd_increase];
}

- (void)bsd_increaseBy:(NSInteger)number
{
    [[self bottomView] bsd_increaseBy:number];
}

- (void)bsd_decrease
{
    [[self bottomView] bsd_decrease];
}

- (void)bsd_decreaseBy:(NSInteger)number
{
    [[self bottomView] bsd_decreaseBy:number];
}

#pragma mark - 获取Badge的父视图

- (UIView *)bottomView
{
    // 通过Xcode视图调试工具找到UITabBarItem原生Badge所在父视图
    UIView *tabBarButton = [self valueForKey:@"_view"];
    for (UIView *subView in tabBarButton.subviews) {
        if (subView.superclass == NSClassFromString(@"UIImageView")) {
            return subView;
        }
    }
    return tabBarButton;
}

@end
