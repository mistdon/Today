//
//  SDWritingToolbar.h
//  Today
//
//  Created by Shendong on 2017/11/20.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SDToolBarType){
    SDToolBarTypeTitle, //添加标题
    SDToolBarTypeLocation // 添加地理位置
};

@interface SDWritingToolbar : UIView

@property (nonatomic, copy) void(^callBackBlock)(SDToolBarType type);

+ (instancetype)loadFromNib;

@end
