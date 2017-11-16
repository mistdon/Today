//
//  SDNetworking.m
//  SDNetworking
//
//  Created by Shendong on 2017/11/5.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "SDNetworking.h"

@implementation SDNetworking

+ (instancetype)sharedInstance{
    static SDNetworking *networking;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networking = [SDNetworking new];
    });
    return networking;
}
- (NSString *)name{
    return NSStringFromClass([self class]);
}
- (void)changeName:(NSString *)name{
    [self setValue:@"shendong" forKey:@"name"];
}
@end
