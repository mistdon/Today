//
//  LeanCloud.m
//  Today
//
//  Created by shendong on 2017/2/21.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "LeanCloud.h"
#import <AVOSCloud/AVOSCloud.h>

static NSString *const LeanCloudAppId  = @"gUvP9HwanFccpAnkYwiMtrGS-gzGzoHsz";
static NSString *const LeanCloudAppkey = @"4prmedx96Ra3xdsVuYRYGJ3C";

@implementation LeanCloud

+ (void)setupLeanCloud{
    [AVOSCloud setApplicationId:LeanCloudAppId clientKey:LeanCloudAppkey];
#ifdef TESTING
    [AVAnalytics setAnalyticsEnabled:NO];
#endif
    
    if ([AVUser currentUser] == nil) {
        //登陆
        [AVUser logInWithUsernameInBackground:@"大东哥" password:@"123456" block:^(AVUser * _Nullable user, NSError * _Nullable error) {
            if (error) {
                NSLog(@"登录失败");
            }else{
                NSLog(@"登录成功: username = %@",user.username);
            };
        }];
    }else{
        NSLog(@"已登录");
    }
    
    
}
+ (void)setupAnalysis: (nullable NSDictionary *)launchOptions{
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
}

@end
