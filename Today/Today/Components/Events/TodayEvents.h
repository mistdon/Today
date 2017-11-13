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

NS_ASSUME_NONNULL_BEGIN

//! 日记Item
@interface TodayEvents : AVObject<AVSubclassing>

@property (nonatomic, strong, readonly) Account *owner; //所有者

@property (nonatomic, copy) NSString *title; //标题

@property (nonatomic, copy) NSString *contents; //内容

//@property (nonatomic, strong) NSDate *beginDate; //开始时间
//
//@property (nonatomic, strong) NSDate *endDate; //结束时间

@property (nonatomic) NSDate *date;

@property (nonatomic, strong, nullable) UIImage *image;

@property (nonatomic, copy, nullable) NSString *tag; //标签

@property (nonatomic, copy, nullable) NSString *group; //群组

//! 背景图片
@property (nonatomic, copy) NSString *backgroundPost;
/*
 
 待定需求：
    
    1. 贴纸
 
 */

+ (instancetype)event;

+ (instancetype)eventWithTitle:(NSString *)title content:(NSString *)content;

@end

@interface TodayEvents(AVHelper)

//! 创建一条日志, 并且保存
- (BOOL)saveEvents;
//! 删除本条目录
- (BOOL)deleteEvents;
//! 查询所有日志
+ (NSArray<__kindof TodayEvents *> *)queryAllEvents;

@end

NS_ASSUME_NONNULL_END
