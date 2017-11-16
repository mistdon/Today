//
//  UIColor+SDColor.m
//  Today
//
//  Created by shendong on 2017/11/16.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "UIColor+SDColor.h"
#import <HexColors/HexColors.h>

UIColor *HexColor(NSString *hexStr){
    return [UIColor hx_colorWithHexRGBAString:hexStr];
}
UIColor *HexColorAlpha(NSString *hexStr, CGFloat alpha){
    return [UIColor hx_colorWithHexRGBAString:hexStr alpha:alpha];
}

@implementation UIColor (SDColor)

@end
