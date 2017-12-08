//
//  SDSlideMenuItem.m
//  Today
//
//  Created by shendong on 2017/12/7.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "SDSlideMenuItem.h"

@implementation SDSlideMenuItem

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:frame];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.backgroundColor = [UIColor greenColor];
        [self addSubview:_imageView];
    }
    return self;
}
+ (instancetype)menuWithImage:(UIImage *)img{
    return [[self alloc] initWithImage:img];
}
- (instancetype)initWithImage:(UIImage *)img{
    SDSlideMenuItem *menu = [SDSlideMenuItem new];
    menu.imageView.image = img;
    return self;
}

@end
