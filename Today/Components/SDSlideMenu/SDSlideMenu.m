//
//  SDSlideMenu.m
//  Today
//
//  Created by shendong on 2017/12/7.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "SDSlideMenu.h"
#import <SDViewHelper/UIView+RectCorner.h>

static const CGFloat KMargin = 5;

@interface SDSlideMenu()
@property (nonatomic) NSMutableArray<__kindof SDSlideMenuItem *> *inner_items;
@property (nonatomic) UIStackView *stackView;
@end

@implementation SDSlideMenu

- (NSMutableArray<__kindof SDSlideMenuItem *> *)inner_items{
    if (!_inner_items) {
        _inner_items = [NSMutableArray new];
    }
    return _inner_items;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return  self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    self.backgroundColor = [UIColor redColor];
    [self sd_cornerAll];
    [self addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIStackView *stack = [[UIStackView alloc] initWithFrame:self.frame];
    stack.backgroundColor = [UIColor redColor];
    stack.axis = UILayoutConstraintAxisHorizontal;
    stack.distribution = UIStackViewDistributionFillEqually;
    stack.alignment = UIStackViewAlignmentFill;
    self.stackView = stack;
}
- (void)tapAction:(UIButton *)sender{
    if(self.selected){
        [self closeMenu];
    }else{
        [self showMenu];
    }
}
// MARK: - public method
- (void)addItems:(NSArray<__kindof SDSlideMenuItem *> *)items{
    [self.inner_items addObjectsFromArray:items];
}
- (void)showMenu{
    NSAssert(self.superview, @"The superView should not be nil, you should add it on superView");
    if (self.stackView.superview == nil) {
//        UIStackView *stack = [[UIStackView alloc] initWithFrame:self.frame];
//        stack.axis = UILayoutConstraintAxisHorizontal;
//        for (SDSlideMenuItem *item in self.inner_items) {
//            [stack addArrangedSubview:item];
//        }
//        [self.superview addSubview:stack];
//        self.stackView = stack;
        for (SDSlideMenuItem *item in self.inner_items) {
            [self.stackView addArrangedSubview:item];
        }
        [self.superview addSubview:self.stackView];
        
        
        
    }
    [UIView animateWithDuration:2 animations:^{
        CGRect frame = _stackView.frame;
        frame = CGRectMake(KMargin, 0, CGRectGetMinX(self.frame) - KMargin, CGRectGetHeight(self.frame));
        _stackView.frame = frame;
    }];
}
- (void)closeMenu{
    if (!_stackView || _stackView.superview) return;
    [UIView animateWithDuration:2 animations:^{
        CGRect frame = _stackView.frame;
        frame = CGRectZero;
        _stackView.frame = frame;
    }];
}

@end
