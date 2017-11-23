//
//  TodayEvents.m
//  Today
//
//  Created by shendong on 2017/2/21.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "SDEventItem.h"
#import "Account.h"
#import "TodayConstant.h"
#import <DateTools/DateTools.h>

@implementation SDEventItem

@dynamic title, contents, tag, group, geoPoint, locationStr;

RegisterAVObject

+ (instancetype)event{
    return [SDEventItem objectWithClassName:NSStringFromClass([self class])];
}

+ (instancetype)eventWithTitle:(NSString *)title content:(NSString *)content{
    SDEventItem *event = [SDEventItem event];
    event.title = title;
    return event;
}
@end

@implementation SDEventItem(Transfer)

- (NSString *)sd_formateCreateDateString{
    return [self.createdAt formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

@end

@implementation SDEventItem(AVHelper)

- (BOOL)saveEvents{
    NSError *error = nil;
    [self save:&error];
    if(error)return NO;
    return YES;
}
- (BOOL)deleteEvents{
    return YES;
}
+ (NSArray<__kindof SDEventItem *> *)queryAllEvents{
    AVQuery *query = [AVQuery queryWithClassName:NSStringFromClass([self class])];
    [query includeKey:@"image"];
    NSArray *array =  [query findObjects];
    return array;
}
// MARK: - public method
+ (RACSignal *)queryAllCurrentUserEvents{
    RACReplaySubject *subject = [RACReplaySubject subject];
    AVQuery *query = [AVQuery queryWithClassName:NSStringFromClass([self class])];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"owner"];
    [query includeKey:@"image"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            [subject sendNext:objects];
        }else{
            [subject sendError:error];
        };
    }];
    return subject;
}
+ (RACSignal *)queryEventItemById:(NSString *)objectId{
    RACReplaySubject *subject = [RACReplaySubject subject];
    AVQuery *query = [AVQuery queryWithClassName:NSStringFromClass([self class])];
    [query getObjectInBackgroundWithId:objectId block:^(AVObject * _Nullable object, NSError * _Nullable error) {
        if ((!error)) {
            [subject sendNext:object];
        }else{
            [subject sendError:error];
            [SDToast error:error.localizedDescription];
        };
    }];
    return subject;
}

@end
