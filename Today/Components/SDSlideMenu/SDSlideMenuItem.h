//
//  SDSlideMenuItem.h
//  Today
//
//  Created by shendong on 2017/12/7.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDSlideMenuItem : UIControl

@property (nonatomic, strong) UIImageView *imageView;

+ (instancetype)menuWithImage:(UIImage *)img;

@end
