//
//  SDConvenientFunc.h
//  Today
//
//  Created by shendong on 2017/11/15.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

FOUNDATION_EXPORT UIFont * font(CGFloat fontSize);
FOUNDATION_EXPORT UIFont * font_bold(CGFloat fontSize);
FOUNDATION_EXPORT CGFloat screen_width(void);
FOUNDATION_EXPORT CGFloat screen_height(void);
FOUNDATION_EXPORT CGFloat adapt_width(CGFloat width);
FOUNDATION_EXPORT CGFloat adapt_height(CGFloat height);
FOUNDATION_EXPORT CGFloat navbar_height(void);
FOUNDATION_EXPORT CGFloat tabbar_height(void);

@interface SDConvenientFunc : NSObject

@end
