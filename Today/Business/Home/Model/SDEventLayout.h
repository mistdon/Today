//
//  SDEventLayout.h
//  Today
//
//  Created by shendong on 2017/11/15.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYKit/YYKit.h>
#import "SDEventItem.h"

FOUNDATION_EXPORT CGFloat const KCellTextFontSize; //文本字体大小
FOUNDATION_EXPORT CGFloat const KCellPaddingText;  //文本与其它元素留白

typedef NS_ENUM(NSUInteger, SDEventLayoutType){
    SDEventLayoutTypeHome //首页样式
};

@interface SDEventLayout : NSObject

- (instancetype)initWithTodayEvents:(SDEventItem *)event;
- (instancetype)initWithTodayEvents:(SDEventItem *)event maxTextRow:(NSUInteger)maxTextRow;
@property (nonatomic) SDEventItem *event;
//! 文本行数限制(默认为0, 即不限行高; 首页限定行高为3行？)
@property (nonatomic, assign) NSUInteger maxTextRow;
//! 计算布局
- (void)layout;
//! 总高度
@property (nonatomic, assign) CGFloat totalHeight;
//! 有效宽度
@property (nonatomic, assign) CGFloat totalWidth;
//! 文本高度
@property (nonatomic, assign) CGFloat textHeight;
//! 内边距
@property (nonatomic, assign) CGFloat padding;
//! 底部外边距
@property (nonatomic, assign) CGFloat bottomMargin;
@property (nonatomic) YYTextLayout *textLayout;
@end


/**
 设置文本Line的行高
 
 Relative Links:
  https://github.com/ibireme/YYText/issues/493
 */
@interface SDEventLinePositionModifier: NSObject<YYTextLinePositionModifier>

@property (nonatomic) UIFont *font; // 基准字体 (例如 Heiti SC/PingFang SC)
@property (nonatomic, assign) CGFloat paddingTop; //文本顶部留白
@property (nonatomic, assign) CGFloat paddingBottom; //文本底部留白
@property (nonatomic, assign) CGFloat lineHeightMultiple; //行距倍数

- (CGFloat)heightForLineCount:(NSUInteger)lineCount;

@end
