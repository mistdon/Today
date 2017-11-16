//
//  NSDate+events.m
//  Today
//
//  Created by shendong on 2017/2/21.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "NSDate+events.h"


@implementation NSDate (events)

+ (NSDate *)today{
    NSDate *date = [NSDate date];
    NSString *str = [date formattedDateWithFormat:@"yyyy-MM-dd"];
    NSLog(@"str = %@",str);
    NSDate *newew = [NSDate dateWithString:str formatString:@"yyyy-MM-dd" timeZone:[NSTimeZone localTimeZone]];
    return  newew;
}

+ (NSDate *)firstDayofMonth{
    return [NSDate dateWithYear:[NSDate today].year month:[NSDate today].month day:1];
}
+ (NSDate *)firstDayOfNextMonth{
    return [[NSDate firstDayofMonth] dateByAddingMonths:1];
}

@end
