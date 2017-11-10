//
//  Account.h
//  Today
//
//  Created by shendong on 2017/2/21.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

typedef NS_ENUM(NSUInteger, UserType){
    UserTypeVistor,
    UserTypeNormal
};
typedef NS_ENUM(NSUInteger, GenderType){
    GenderTypeUnknown,
    GenderTypeFemale,
    GenderTypeMale
};

@interface Account : AVUser<AVSubclassing>

@property (nonatomic, strong) NSURL *avator;
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, assign) GenderType gender;

@end
