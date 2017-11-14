//
//  TodayEvents.m
//  Today
//
//  Created by shendong on 2017/2/21.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "TodayEvents.h"
#import "Account.h"
#import "TodayConstant.h"
#import <DateTools/DateTools.h>

@implementation TodayEvents

@dynamic title, contents, tag, group, geoPoint, locationStr;

RegisterAVObject

- (instancetype)init{
    if (self = [super init]) {
        [self setDefaultValue];
    }
    return self;
}
- (void)setDefaultValue{
    [self setObject:[Account currentUser] forKey:@"owner"];
}

+ (instancetype)event{
    return [TodayEvents objectWithClassName:@"TodayEvents"];
}

+ (instancetype)eventWithTitle:(NSString *)title content:(NSString *)content{
    TodayEvents *event = [TodayEvents event];
    event.title = title;
    return event;
}
@end

@implementation TodayEvents(Transfer)

- (NSString *)sd_formateCreateDateString{
    return [self.createdAt formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

@end

@implementation TodayEvents(AVHelper)

- (BOOL)saveEvents{
    NSError *error = nil;
    [self save:&error];
    if(error)return NO;
    return YES;
}
- (BOOL)deleteEvents{
    return YES;
}
+ (NSArray<__kindof TodayEvents *> *)queryAllEvents{
    AVQuery *query = [AVQuery queryWithClassName:@"TodayEvents"];
    [query includeKey:@"image"];
    NSArray *array =  [query findObjects];
    return array;
}

@end
