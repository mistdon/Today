//
//  EventsManager.h
//  Today
//
//  Created by shendong on 2017/2/27.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SDEventItem;

@interface EventsManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL)addEvent:(SDEventItem *)event;

- (BOOL)deleteEvent:(SDEventItem *)event;

- (BOOL)editEvent:(SDEventItem *)event;

- (NSArray<__kindof SDEventItem *> *)queryEventsByPara:(NSDictionary *)parameters;

@end

NS_ASSUME_NONNULL_END
