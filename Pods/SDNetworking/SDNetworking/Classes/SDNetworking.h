//
//  SDNetworking.h
//  SDNetworking
//
//  Created by Shendong on 2017/11/5.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDNetworking : NSObject

@property (nonatomic, copy, readonly) NSString *name;

+ (instancetype)sharedInstance;

- (void)changeName:(NSString *)name;
@end
