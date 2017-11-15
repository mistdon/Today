//
//  SDConvenientFunc.m
//  Today
//
//  Created by shendong on 2017/11/15.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "SDConvenientFunc.h"
#import "SDRootViewController.h"

UIFont * font(CGFloat fontSize){
    return [UIFont systemFontOfSize:fontSize];
}
UIFont * font_bold(CGFloat fontSize){
    return [UIFont boldSystemFontOfSize:fontSize];
}
CGFloat screen_width(void){
    return [UIScreen mainScreen].bounds.size.width;
}
CGFloat screen_height(void){
    return [UIScreen mainScreen].bounds.size.height;
}
CGFloat adapt_width(CGFloat width){
    return screen_width() / 375.f * width;
}
CGFloat adapt_height(CGFloat height){
    return screen_height() / 667.f * height;
}
CGFloat navbar_height(void){
    return CGRectGetMaxY(SDRootViewController.rootViewController.navigationBar.frame);
}
@implementation SDConvenientFunc

@end
