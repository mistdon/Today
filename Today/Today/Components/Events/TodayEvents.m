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

@implementation TodayEvents

@dynamic owner, title, contents, beginDate, endDate, tag, group;

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

+ (instancetype)eventWithTitle:(NSString *)tile content:(NSString *)content{
    TodayEvents *event = [TodayEvents event];
    event.date = [NSDate date];
    return event;
}
@end
