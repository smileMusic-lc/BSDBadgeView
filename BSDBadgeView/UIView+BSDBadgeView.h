//
//  UIView+BSDBadgeView.h
//  instalment
//
//  Created by 梁策 on 2019/12/19.
//  Copyright © 2019 BSD. All rights reserved.
//

@class BSDBadgeControl;

typedef NS_ENUM(NSUInteger, BSDBadgeViewFlexMode);

#pragma mark - Protocol

@protocol BSDBadgeView <NSObject>

@required

@property (nonatomic, strong, readonly) BSDBadgeControl *badgeView;

/**
 添加带文本内容的Badge, 默认右上角, 红色, 18pts
 */
- (void)bsd_addBadgeWithText:(NSString *)text;

/**
 添加带数字的Badge, 默认右上角,红色,18pts
 */
- (void)bsd_addBadgeWithNumber:(NSInteger)number;

/**
 添加带颜色的小圆点, 默认右上角, 红色, 8pts
 */
- (void)bsd_addDotWithColor:(UIColor *)color;

/**
添加外边框
*/
- (void)bsd_setBadgeBorderWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

/**
 设置Badge的高度,因为Badge宽度是动态可变的,通过改变Badge高度,其宽度也按比例变化,方便布局
 
 (注意: 此方法需要将Badge添加到控件上后再调用!!!)
 
 @param height 高度大小
 */
- (void)bsd_setBadgeHeight:(CGFloat)height;

/**
 设置Badge的偏移量, Badge中心点默认为其父视图的右上角
 
 @param x X轴偏移量 (x<0: 左移, x>0: 右移) axis offset (x <0: left, x> 0: right)
 @param y Y轴偏移量 (y<0: 上移, y>0: 下移) axis offset ( Y <0: up, y> 0: down)
 */
- (void)bsd_moveBadgeWithX:(CGFloat)x Y:(CGFloat)y;


/**
 设置Badge伸缩的方向
 
 BSDBadgeViewFlexModeHead,    左伸缩 Head Flex    : <==●
 BSDBadgeViewFlexModeTail,    右伸缩 Tail Flex    : ●==>
 BSDBadgeViewFlexModeMiddle   左右伸缩 Middle Flex : <=●=>
 
 @param flexMode : Default is BSDBadgeViewFlexModeTail
 */
- (void)bsd_setBadgeFlexMode:(BSDBadgeViewFlexMode)flexMode;

/// 显示Badge
- (void)bsd_showBadge;

/// 隐藏Badge
- (void)bsd_hiddenBadge;

/// 数字增加/减少, 注意:以下方法只适用于Badge内容为纯数字的情况
- (void)bsd_increase;
- (void)bsd_increaseBy:(NSInteger)number;
- (void)bsd_decrease;
- (void)bsd_decreaseBy:(NSInteger)number;

@end

#pragma mark - Category

@interface UIView (PPBadgeView) <BSDBadgeView>

@end

@interface UIView (Constraint)
- (NSLayoutConstraint *)widthConstraint;
- (NSLayoutConstraint *)heightConstraint;
- (NSLayoutConstraint *)topConstraintWithItem:(id)item;
- (NSLayoutConstraint *)leadingConstraintWithItem:(id)item;
- (NSLayoutConstraint *)bottomConstraintWithItem:(id)item;
- (NSLayoutConstraint *)trailingConstraintWithItem:(id)item;
- (NSLayoutConstraint *)centerXConstraintWithItem:(id)item;
- (NSLayoutConstraint *)centerYConstraintWithItem:(id)item;
@end
