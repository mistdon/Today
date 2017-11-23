//
//  DXTableComponent.h
//  ejc
//
//  Created by shendong on 2017/10/20.
//  Copyright © 2017年 Shanghai Elephant Financial Services Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol DXTableComponent;
@protocol DXTableComponentDelegate<NSObject>

- (void)tableComponent:(id<DXTableComponent>)component didSelectedAtIndex:(NSUInteger)index;

@end

@protocol DXTableComponent <NSObject>

@required

- (NSString *)cellIdentifier;
- (NSString *)headerIdentifier;
- (NSString *)footerIdentifier;

- (NSInteger)numberOfItems;

- (CGFloat)heightForComponentItemAtIndex:(NSUInteger)index;
- (CGFloat)heightForComponentHeader;
- (CGFloat)heightForComponentFooter;

- (__kindof UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
- (void)reloadDataWithTableView:(UITableView *)tableView inSection:(NSInteger)section;
- (void)reloadDataWithTableView:(UITableView *)tableView;

@optional

- (__kindof UIView *)headerForTableView:(UITableView *)tableView;
- (__kindof UIView *)footerForTableView:(UITableView *)tableView;
- (void)willDisPlayCell:(__kindof UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath;
- (void)didEndDisplayingCell:(__kindof UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectItemAtIndex:(NSUInteger)index;

@end
