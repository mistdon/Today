//
//  HomeItemTableViewCell.m
//  Today
//
//  Created by shendong on 2017/11/14.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "HomeItemTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HomeItemTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;

@end
@implementation HomeItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setTodayEvents:(TodayEvents *)todayEvents{
    _todayEvents = todayEvents;
    self.titleLabel.text = todayEvents.title;
    self.contentTextView.text = todayEvents.contents;
    [self.postImageView sd_setImageWithURL:[NSURL URLWithString:todayEvents.image.url] placeholderImage:nil];
}

@end
