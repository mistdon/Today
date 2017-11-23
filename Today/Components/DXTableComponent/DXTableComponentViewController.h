//
//  DXTableComponentViewController.h
//  ejc
//
//  Created by shendong on 2017/10/20.
//  Copyright © 2017年 Shanghai Elephant Financial Services Co., Ltd. All rights reserved.
//


#import "SDBaseViewController.h"
#import "DXTableComponent.h"

@interface DXTableComponentViewController : SDBaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, readonly) UITableView *tableView;

@property (nonatomic) NSArray<__kindof id<DXTableComponent>> *components;

@property (nonatomic, assign) BOOL supportTabBar;

@property (nonatomic, assign) UITableViewStyle style;

@end

