//
//  HomeItemTableViewCell.m
//  Today
//
//  Created by shendong on 2017/11/14.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "HomeItemTableViewCell.h"
#import "SDConvenientFunc.h"
#import <YYKit/UIView+YYAdd.h>

@interface HomeItemTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet YYLabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;

@end
@implementation HomeItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = font(15);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setLayout:(SDEventLayout *)layout{
    _layout = layout;
    self.contentView.height = layout.totalHeight;
    [self bindData:layout.event];
}
- (void)bindData:(SDEventItem *)item{
    self.titleLabel.text = item.title;
    self.locationLabel.text = item.locationStr;
    self.dateLabel.text = [item sd_formateCreateDateString];
    self.contentLabel.text = item.contents;
}

@end
