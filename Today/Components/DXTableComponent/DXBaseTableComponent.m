//
//  DXBaseTableComponent.m
//  ejc
//
//  Created by shendong on 2017/10/20.
//  Copyright © 2017年 Shanghai Elephant Financial Services Co., Ltd. All rights reserved.
//

#import "DXBaseTableComponent.h"
@interface DXBaseTableComponent()
@property (nonatomic, weak) UITableView *tableView;
@end
@implementation DXBaseTableComponent

- (instancetype)initWithTableView:(UITableView *)tableView delegate:(id<DXTableComponentDelegate>)delegate{
    if (self = [super init]) {
        self.cellIdentifier   = [NSStringFromClass([self class]) stringByAppendingString:@"-Identifier"];
        self.headerIdentifier = [NSStringFromClass([self class]) stringByAppendingString:@"-HeaderIdentifier"];
        self.footerIdentifier = [NSStringFromClass([self class]) stringByAppendingString:@"-FooterIdentifier"];
        self.tableView = tableView;
        self.delegate  = delegate;
        [self registerWithTableView:tableView];
    }
    return self;
}
- (instancetype)initWithTableView:(UITableView *)tableView{
    return [self initWithTableView:tableView delegate:nil];
}
+ (instancetype)componentWithTableView:(UITableView *)tableView delegate:(id<DXTableComponentDelegate>)delegate{
    id<DXTableComponent> component = [[self alloc] initWithTableView:tableView delegate:delegate];
    return component;
}
+ (instancetype)componentWithTableView:(UITableView *)tableView{
    return [self componentWithTableView:tableView delegate:nil];
}
// MARK: - DXTableComponent delegate
- (NSInteger)numberOfItems{
    return 0;
}
- (CGFloat)heightForComponentHeader{
    return 0;
}
- (CGFloat)heightForComponentFooter{
    return 0;
}
- (CGFloat)heightForComponentItemAtIndex:(NSUInteger)index{
    return 44.f;
}

- (__kindof UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    NSAssert(YES, @"This method should be overrided by subclass.");
    return cell;
}

- (void)reloadDataWithTableView:(UITableView *)tableView {
    NSAssert(YES, @"This method should be overrided by subclass.");
}
- (void)reloadDataWithTableView:(UITableView *)tableView inSection:(NSInteger)section{
    
}

// MARK: - public method
- (void)registerWithTableView:(UITableView *)tableView{
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:self.cellIdentifier];
}
@end
