//
//  SDAdView.m
//  Today
//
//  Created by Shendong on 2017/11/19.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "SDAdView.h"
#import <Masonry/Masonry.h>
#import "UIImageView+SDImageManagerHelper.h"

@interface SDAdView()
@property (nonatomic) UIImageView *postImageView;
@end
@implementation SDAdView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    UIImageView *post = [UIImageView new];
    post.contentMode  = UIViewContentModeScaleAspectFill;
    [self addSubview:post];
    [post mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.postImageView = post;
}
- (void)setupUrl:(NSString *)urlStr{
    [self.postImageView sd_setImageWithUrlString:urlStr];
}

@end
