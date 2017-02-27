//
//  APNDispatcher.h
//  Today
//
//  Created by shendong on 2017/2/27.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APNDispatcher : NSObject

+ (instancetype)sharedInstance;

+ (void)registerAPNService;

@end
