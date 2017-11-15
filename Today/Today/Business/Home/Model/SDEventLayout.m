//
//  SDEventLayout.m
//  Today
//
//  Created by shendong on 2017/11/15.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "SDEventLayout.h"
#import "SDConvenientFunc.h"

@implementation SDEventLayout

- (instancetype)initWithTodayEvents:(SDEventItem *)event{
    if (!event) return nil;
    self = [super init];
    _event = event;
    [self layout];
    return self;
}
- (void)layout{
    _padding = 5.f;
    _bottomMargin = 10.f;
    [self layoutText];
    _totalHeight = 0;
    _totalHeight += 44;
    _totalHeight += 20;
    _totalHeight += _padding * 2;
    _totalHeight += _textHeight;
    _totalHeight += _bottomMargin;
}
- (void)layoutText{
    _textHeight = 0;
    _textLayout = nil;
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:_event.contents attributes:@{NSFontAttributeName:font(15)}];
    YYTextContainer *container = [YYTextContainer new];
    container.size = CGSizeMake(screen_width() - 60 - _padding * 2, CGFLOAT_MAX);
    container.maximumNumberOfRows = 0;
    _textLayout = [YYTextLayout layoutWithContainer:container text:att];
    if (!_textLayout) return;
    CGFloat ttHeight = _textLayout.textBoundingSize.height;
    NSLog(@"textHeight = %lf",ttHeight);
    _textHeight = ttHeight;
}
@end
