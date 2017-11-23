//
//  SDToast.m
//  Today
//
//  Created by shendong on 2017/11/16.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "SDToast.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UIColor+SDColor.h"

@implementation SDToast

+ (void)initialize{
    if(self == [SDToast class]){
        [SVProgressHUD setInfoImage:nil];
        [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"submit_success"]];
        [SVProgressHUD setErrorImage:[UIImage imageNamed:@"submit_fail"]];
        [SVProgressHUD setForegroundColor:[UIColor orangeColor]];
        [SVProgressHUD setMaximumDismissTimeInterval:2.f];
        [SVProgressHUD setMinimumDismissTimeInterval:1.f];
        [SVProgressHUD setMinimumSize:CGSizeMake(150.f, 100.f)];
        [SVProgressHUD setBackgroundColor:[UIColor sd_mainThemeColor]];
        [SVProgressHUD setImageViewSize:CGSizeMake(60, 60)];
        [SVProgressHUD setFont:[UIFont systemFontOfSize:18]];
    }
}

+ (void)success:(NSString *)info{
    [SVProgressHUD showSuccessWithStatus:info];
}
+ (void)error:(NSString *)info{
    [SVProgressHUD showErrorWithStatus:info];
}
+ (void)message:(NSString *)info{
    [SVProgressHUD showInfoWithStatus:info];
}

+ (void)loading{
    [SVProgressHUD showWithStatus:@"加载中"];
}

+ (void)dismiss{
    [SVProgressHUD dismiss];
}

@end
