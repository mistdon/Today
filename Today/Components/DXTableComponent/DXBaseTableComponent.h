//
//  DXBaseTableComponent.h
//  ejc
//
//  Created by shendong on 2017/10/20.
//  Copyright © 2017年 Shanghai Elephant Financial Services Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXTableComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface DXBaseTableComponent : NSObject<DXTableComponent>
@property (nonatomic, weak) id<DXTableComponentDelegate> delegate;
@property (nonatomic, weak, readonly) UITableView *tableView;
@property (nonatomic) NSString *cellIdentifier;
@property (nonatomic) NSString *headerIdentifier;
@property (nonatomic) NSString *footerIdentifier;

+ (instancetype)componentWithTableView:(UITableView *)tableView;
+ (instancetype)componentWithTableView:(UITableView *)tableView delegate:(nullable id<DXTableComponentDelegate>)delegate;
- (instancetype)initWithTableView:(UITableView *)tableView;
- (instancetype)initWithTableView:(UITableView *)tableView delegate:(nullable id<DXTableComponentDelegate>)delegate;

- (instancetype)init NS_UNAVAILABLE;
- (void)registerWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
