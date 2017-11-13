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

@dynamic owner, title, contents, date, tag, group;

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
    event.date = [NSDate date];
    return event;
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
    NSArray *array =  [query findObjects];
    return array;
}

@end
