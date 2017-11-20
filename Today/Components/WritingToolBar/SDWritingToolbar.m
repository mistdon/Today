//
//  SDWritingToolbar.m
//  Today
//
//  Created by Shendong on 2017/11/20.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "SDWritingToolbar.h"
@interface SDWritingToolbar()
@property (nonatomic, weak) UIButton *addTitleButton;
@property (nonatomic, weak) UIButton *addLocationButton;
@end
@implementation SDWritingToolbar

+ (instancetype)loadFromNib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor orangeColor];
}
- (IBAction)buttonClicked:(UIButton *)sender {
    if (self.callBackBlock) {
        self.callBackBlock(sender.tag - 500);
    }
}

@end
