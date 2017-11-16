//
//  WritingViewController.h
//  Today
//
//  Created by shendong on 2017/11/10.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "BaseViewController.h"
#import "SDEventItem.h"

@interface WritingViewController : BaseViewController

//! 如果有值,就是编辑; 没有值,就是新加
@property (nonatomic, nullable) SDEventItem *eventItem;

@end
