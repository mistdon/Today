//
//  SDToast.h
//  Today
//
//  Created by shendong on 2017/11/16.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDToast : NSObject

+ (void)success:(nullable NSString *)info;

+ (void)error:(nullable NSString *)info;

+ (void)message:(nullable NSString *)info;

+ (void)loading;

+ (void)dismiss;

@end
