//
//  UIImageView+SDImageManagerHelper.h
//  Today
//
//  Created by shendong on 2017/11/15.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const KDefaultBackgroundImageUrl;

@interface UIImageView (SDImageManagerHelper)

- (void)sd_setImageWithUrlString:(NSString *)str;

@end
