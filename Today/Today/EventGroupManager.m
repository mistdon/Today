
//
//  EventGroupManager.m
//  Today
//
//  Created by shendong on 2017/2/27.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "EventGroupManager.h"


@interface EventGroupManager()
@property (nonatomic, strong) NSMutableArray<__kindof NSString *> *linner_groups;
@end
@implementation EventGroupManager

+ (instancetype)sharedInstance{
    static EventGroupManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[EventGroupManager alloc] init];
    });
    return manager;
}
- (NSMutableArray<__kindof NSString *> *)linner_groups{
    if (!_linner_groups) {
        _linner_groups = [NSMutableArray array];
    }
    return _linner_groups;
}

+ (NSArray<__kindof NSString *> *)groups{
    if ([[self sharedInstance] linner_groups].count < 1) {
        [[[self sharedInstance] linner_groups] addObject:@"日常"];
    }
    return [[[EventGroupManager sharedInstance] linner_groups] copy];
}
- (BOOL)addNewGroup:(NSString *)groupName{
    NSParameterAssert(groupName);
    [self.linner_groups addObject:groupName];
    return YES;
}
- (BOOL)deleteGroup:(NSString *)groupName{
    NSParameterAssert(groupName);
    if ([self.linner_groups containsObject:groupName]) {
        [self.linner_groups removeObject:groupName];
        return YES;
    }
    return NO;
}
- (BOOL)editGroup:(NSString *)groupName toNewGroupName:(NSString *)newGroupName{
    NSParameterAssert(groupName);
    NSParameterAssert(newGroupName);
    if ([self.linner_groups containsObject:groupName]) {
        NSUInteger index = [self.linner_groups indexOfObject:groupName];
        [self.linner_groups replaceObjectAtIndex:index withObject:newGroupName];
        return YES;
    }
    return NO;
}
@end
