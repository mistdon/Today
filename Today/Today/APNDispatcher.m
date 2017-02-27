//
//  APNDispatcher.m
//  Today
//
//  Created by shendong on 2017/2/27.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "APNDispatcher.h"
#import <UIKit/UIKit.h>

@implementation APNDispatcher

+ (instancetype)sharedInstance{
    static APNDispatcher *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[APNDispatcher alloc] init];
    });
    return manager;
}

+ (void)registerAPNService{

}


@end
