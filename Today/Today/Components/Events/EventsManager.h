//
//  EventsManager.h
//  Today
//
//  Created by shendong on 2017/2/27.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class TodayEvents;

@interface EventsManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL)addEvent:(TodayEvents *)event;

- (BOOL)deleteEvent:(TodayEvents *)event;

- (BOOL)editEvent:(TodayEvents *)event;

- (NSArray<__kindof TodayEvents *> *)queryEventsByPara:(NSDictionary *)parameters;

@end

NS_ASSUME_NONNULL_END
