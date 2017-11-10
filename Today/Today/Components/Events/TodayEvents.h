//
//  TodayEvents.h
//  Today
//
//  Created by shendong on 2017/2/21.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@class Account;

@interface TodayEvents : AVObject<AVSubclassing>

@property (nonatomic, strong) Account *owner; //所有者

@property (nonatomic, copy) NSString *title; //标题

@property (nonatomic, copy) NSString *contents; //内容

@property (nonatomic, strong) NSDate *beginDate; //开始时间

@property (nonatomic, strong) NSDate *endDate; //结束时间

@property (nonatomic) NSDate *date;

@property (nonatomic, copy) NSString *tag; //标签

@property (nonatomic, copy) NSString *group; //群组

//! 背景图片
@property (nonatomic, copy) NSString *backgroundPost;
/*
 
 待定需求：
    
    1. 贴纸
 
 */

+ (instancetype)event;

+ (instancetype)eventWithTitle:(NSString *)tile content:(NSString *)content;

@end
