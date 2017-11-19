//
//  UIColor+SDColor.h
//  Today
//
//  Created by shendong on 2017/11/16.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT UIColor *HexColor(NSString *);
FOUNDATION_EXPORT UIColor *HexColorAlpha(NSString *, CGFloat alpha);

@interface UIColor (SDColor)
//! 主题色 懒人日记APP 15b7b9
+ (UIColor *)sd_mainThemeColor;

+ (UIColor *)sd_lightOrangeColor;

@end
