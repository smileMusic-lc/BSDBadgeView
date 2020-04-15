//
//  BSDBadgeControl.h
//  instalment
//
//  Created by 梁策 on 2019/12/19.
//  Copyright © 2019 BSD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BSDBadgeViewFlexMode) {
    BSDBadgeViewFlexModeHead,    /// 左伸缩 Head Flex    : <==●
    BSDBadgeViewFlexModeTail,    /// 右伸缩 Tail Flex    : ●==>
    BSDBadgeViewFlexModeMiddle   /// 左右伸缩 Middle Flex : <=●=>
};

NS_ASSUME_NONNULL_BEGIN

@interface BSDBadgeControl: UIControl

+ (instancetype)defaultBadge;

/// Set Text
@property (nullable, nonatomic, copy) NSString *text;

/// Set AttributedText
@property (nullable, nonatomic, strong) NSAttributedString *attributedText;

/// Set Font
@property (nonatomic, strong) UIFont *font;

/// SetTextColor
@property (nonatomic, strong) UIColor *textColor;

/// Set background image
@property (nullable, nonatomic, strong) UIImage *backgroundImage;

/// Badge伸缩的方向, Default is BSDBadgeViewFlexModeTail
@property (nonatomic, assign) BSDBadgeViewFlexMode flexMode;

/// 记录Badge的偏移量 Record the offset of Badge
@property (nonatomic, assign) CGPoint offset;

@end

NS_ASSUME_NONNULL_END
