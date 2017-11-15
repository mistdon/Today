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
@interface SDEventItem : AVObject<AVSubclassing>

//@property (nonatomic, strong, readonly) Account *owner; //所有者
//! 文章标题
@property (nonatomic, copy) NSString *title;
//! 记录内容
@property (nonatomic, copy) NSString *contents;
//! 封面图片(最多为一张)
@property (nonatomic, nullable) AVFile *image;
//! 标签(为以后的标签查询做准备)
@property (nonatomic, copy, nullable) NSString *tag; //标签
//! 群组(日记群组,旅游群组)
@property (nonatomic, copy, nullable) NSString *group; //群组
//! 地理坐标位置(数据统计)
@property (nonatomic) AVGeoPoint *geoPoint;
//! 地理位置(拼接成中文显示)
@property (nonatomic, copy) NSString *locationStr;

/*
 待定需求：
    1. 贴纸
 */

+ (instancetype)event;

+ (instancetype)eventWithTitle:(NSString *)title content:(NSString *)content;

@end

// MARK: Transfer
@interface SDEventItem(Transfer)

- (NSString *)sd_formateCreateDateString;

@end

// MARK: AVHelper
@interface SDEventItem(AVHelper)

//! 创建一条日志, 并且保存
- (BOOL)saveEvents;
//! 删除本条目录
- (BOOL)deleteEvents;
//! 查询所有日志
+ (NSArray<__kindof SDEventItem *> *)queryAllEvents;

@end

NS_ASSUME_NONNULL_END
