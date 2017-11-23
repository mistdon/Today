//
//  DXTableComponentViewController.m
//  ejc
//
//  Created by shendong on 2017/10/20.
//  Copyright © 2017年 Shanghai Elephant Financial Services Co., Ltd. All rights reserved.
//

#import "DXTableComponentViewController.h"
#import <Masonry/Masonry.h>
#import "UIColor+SDColor.h"
#import "SDConvenientFunc.h"

@interface DXTableComponentViewController ()
@property (nonatomic) UITableView *tableView;
@end

@implementation DXTableComponentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wpartial-availability"
    if ([self.view respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
#pragma clang diagnostic pop
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.supportTabBar) {
        [self checkSupportTabBar:YES];
    }else{
        [self checkSupportTabBar:NO];
    }
    [self checkSupportTabBar:self.supportTabBar];
}

- (void)checkSupportTabBar:(BOOL)supportTabBar{
    if (supportTabBar) {
//        self.tableView.frame = CGRectMake(0, 0, screen_width(), (screen_height() - tabbar_height() - navbar_height()));
    }else{
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
             make.edges.equalTo(self.view);
        }];
    }
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width(), screen_height()) style:self.style];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setComponents:(NSArray<__kindof id<DXTableComponent>> *)components{
    if (_components != components) {
        _components = components;
        [self.tableView reloadData];
    }
}
- (CGRect)tableViewRectForBounds:(CGRect)bounds{
    return bounds;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.components.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.components[section].numberOfItems;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.components[indexPath.section] heightForComponentItemAtIndex:indexPath.row];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return MAX([self.components[section] heightForComponentHeader], CGFLOAT_MIN);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return MAX([self.components[section] heightForComponentFooter], CGFLOAT_MIN);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.components[indexPath.section] cellForTableView:tableView atIndexPath:indexPath];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([self.components[section] respondsToSelector:@selector(footerForTableView:)]) {
        return [self.components[section] footerForTableView:tableView];
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([self.components[section] respondsToSelector:@selector(headerForTableView:)]) {
        return [self.components[section] headerForTableView:tableView];
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.components.count > indexPath.section && [self.components[indexPath.section] respondsToSelector:@selector(willDisPlayCell:forIndexPath:)]) {
        [self.components[indexPath.section] willDisPlayCell:cell forIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.components.count > indexPath.section &&  [self.components[indexPath.section] respondsToSelector:@selector(didEndDisplayingCell:forIndexPath:)]) {
        [self.components[indexPath.section] didEndDisplayingCell:cell forIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.components.count > indexPath.section && [self.components[indexPath.section] respondsToSelector:@selector(didSelectItemAtIndex:)]) {
        [self.components[indexPath.section] didSelectItemAtIndex:indexPath.row];
    }
}
@end
