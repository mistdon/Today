//
//  EventsManager.m
//  Today
//
//  Created by shendong on 2017/2/27.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "EventsManager.h"
#import "SDEventItem.h"

#import "NSDate+events.h"    //deleteing...


@implementation EventsManager

+ (instancetype)sharedInstance{
    static EventsManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[EventsManager alloc] init];
    });
    return  instance;
}
- (BOOL)addEvent:(SDEventItem *)event{
    if (event == nil) return NO;
    return [event save];
}

- (BOOL)deleteEvent:(SDEventItem *)event{
    if (event == nil)return NO;
    return YES;
}
- (BOOL)editEvent:(SDEventItem *)event{
    return YES;
}

- (NSArray<__kindof SDEventItem *> *)queryEventsByPara:(NSDictionary *)parameters{
   return nil;
}
@end
