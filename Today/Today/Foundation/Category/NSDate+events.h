//
//  NSDate+events.h
//  Today
//
//  Created by shendong on 2017/2/21.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DateTools/DateTools.h>

@interface NSDate (events)

//! 当天0点时间，如“2017-02-21 00:00:00”
+ (NSDate *)today;

//! eg: 2017-02-01 00:00:00
+ (NSDate *)firstDayofMonth;

//! eg: 2017-03-01 00:00:00
+ (NSDate *)firstDayOfNextMonth;

@end
