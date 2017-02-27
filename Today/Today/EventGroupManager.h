//
//  EventGroupManager.h
//  Today
//
//  Created by shendong on 2017/2/27.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EventGroupManager : NSObject

+ (instancetype)sharedInstance;

+ (NSArray<__kindof NSString *> *)groups;

- (BOOL)addNewGroup:(NSString *)groupName;

- (BOOL)deleteGroup:(NSString *)groupName;

- (BOOL)editGroup:(NSString *)groupName toNewGroupName:(NSString *)newGroupName;

@end

NS_ASSUME_NONNULL_END
