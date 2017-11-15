//
//  SDEventLayout.h
//  Today
//
//  Created by shendong on 2017/11/15.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYKit/YYKit.h>
#import "SDEventItem.h"

@interface SDEventLayout : NSObject

- (instancetype)initWithTodayEvents:(SDEventItem *)event;

@property (nonatomic) SDEventItem *event;
//! 计算布局
- (void)layout;
//! 总高度
@property (nonatomic, assign) CGFloat totalHeight;
//! 文本高度
@property (nonatomic, assign) CGFloat textHeight;
//! 内边距
@property (nonatomic, assign) CGFloat padding;
//! 底部外边距
@property (nonatomic, assign) CGFloat bottomMargin;
@property (nonatomic) YYTextLayout *textLayout;
@end
