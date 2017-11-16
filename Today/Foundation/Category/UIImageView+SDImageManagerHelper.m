//
//  UIImageView+SDImageManagerHelper.m
//  Today
//
//  Created by shendong on 2017/11/15.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "UIImageView+SDImageManagerHelper.h"
#import <YYKit/UIImageView+YYWebImage.h>
NSString *const KDefaultBackgroundImageUrl = @"http://img.ivsky.com/img/tupian/pre/201012/25/suse_zhiwen.jpg";

@implementation UIImageView (SDImageManagerHelper)

- (void)sd_setImageWithUrlString:(NSString *)str{
    [self setImageWithURL:[NSURL URLWithString:str] placeholder:nil];
}

@end
