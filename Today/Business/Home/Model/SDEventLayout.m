//
//  SDEventLayout.m
//  Today
//
//  Created by shendong on 2017/11/15.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "SDEventLayout.h"
#import "SDConvenientFunc.h"

CGFloat const KCellTextFontSize = 17;
CGFloat const KCellPaddingText = 10;



@implementation SDEventLayout
- (instancetype)initWithTodayEvents:(SDEventItem *)event maxTextRow:(NSUInteger)maxTextRow{
    if (!event) return nil;
    self = [super init];
    _event = event;
    _maxTextRow = maxTextRow;
    [self layout];
    return self;
}
- (instancetype)initWithTodayEvents:(SDEventItem *)event{
    return [self initWithTodayEvents:event maxTextRow:0];
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
    SDEventLinePositionModifier *modifier = [SDEventLinePositionModifier new];
    modifier.font = [UIFont fontWithName:@"Heiti SC" size:KCellTextFontSize];
    modifier.paddingTop = KCellPaddingText;
    modifier.paddingBottom = KCellPaddingText;
    
    YYTextContainer *container = [YYTextContainer new];
    container.linePositionModifier = modifier;
    container.size = CGSizeMake(screen_width() - 60 - _padding * 2, CGFLOAT_MAX);
    container.maximumNumberOfRows = 0;
    _textLayout = [YYTextLayout layoutWithContainer:container text:att];
    if (!_textLayout) return;
    
    // 如果设置了最大行高,当文本行高大于最大行高时,取最大行高;否则取实际行高;
    // 否则, 取实际行高
    NSUInteger row = self.maxTextRow > 0 ? (_textLayout.rowCount > self.maxTextRow ? self.maxTextRow : _textLayout.rowCount) : (_textLayout.rowCount);
    _textHeight = [modifier heightForLineCount:row];
    
}
@end
// MARK: - SDEventLinePositionModifier
@implementation SDEventLinePositionModifier
- (instancetype)init{
    self = [super init];
    if(kiOS9Later){
        _lineHeightMultiple = 1.34;
    }else{
        _lineHeightMultiple = 1.3125;
    }
    return self;
}
- (void)modifyLines:(NSArray<YYTextLine *> *)lines fromText:(NSAttributedString *)text inContainer:(YYTextContainer *)container{
    CGFloat ascent = _font.pointSize * 0.86;
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    for(YYTextLine *line in lines){
        CGPoint position = line.position;
        position.y = _paddingTop +  ascent + line.row * lineHeight;
        line.position = position;
    }
}
- (id)copyWithZone:(NSZone *)zone{
    SDEventLinePositionModifier *modifier = [self.class new];
    modifier->_font = _font;
    modifier->_paddingTop = _paddingTop;
    modifier->_paddingBottom = _paddingBottom;
    modifier->_lineHeightMultiple = _lineHeightMultiple;
    return modifier;
}
- (CGFloat)heightForLineCount:(NSUInteger)lineCount{
    if(lineCount == 0) return 0;
    CGFloat ascent = _font.pointSize * 0.86;
    CGFloat descent = _font.pointSize * 0.14;
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    return _paddingTop + _paddingBottom + ascent + descent + (lineCount - 1) * lineHeight;
}
@end

