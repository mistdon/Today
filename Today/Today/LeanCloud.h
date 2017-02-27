//
//  LeanCloud.h
//  Today
//
//  Created by shendong on 2017/2/21.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeanCloud : NSObject

+ (void)setupLeanCloud;

+ (void)setupAnalysis: (nullable NSDictionary *)launchOptions;

@end
