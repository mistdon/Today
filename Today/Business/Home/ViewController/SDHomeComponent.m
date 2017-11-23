//
//  SDHomeComponent.m
//  Today
//
//  Created by shendong on 2017/11/23.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "SDHomeComponent.h"
#import "HomeItemTableViewCell.h"
#import "SDRootViewController.h"

static NSString *const KCellIdentifier = @"homeCellIdentifier";

@implementation SDHomeComponent

- (void)registerWithTableView:(UITableView *)tableView{
     [tableView registerNib:[UINib nibWithNibName:@"HomeItemTableViewCell" bundle:nil] forCellReuseIdentifier:KCellIdentifier];
}

- (NSMutableArray<__kindof SDEventLayout *> *)layoutLists{
    if(!_layoutLists){
        _layoutLists = [NSMutableArray new];
    }
    return _layoutLists;
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    HomeItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdentifier forIndexPath:indexPath];
    cell.layout = self.layoutLists[indexPath.row];
    return cell;
}
- (NSInteger)numberOfItems{
    return self.layoutLists.count;
}
- (CGFloat)heightForComponentItemAtIndex:(NSUInteger)index{
    return self.layoutLists[index].totalHeight;
}
- (void)didSelectItemAtIndex:(NSUInteger)index{
    UIViewController *vc = [UIViewController sd_viewController:@"SDEventDetailViewController" arguments:@{@"item":self.layoutLists[index].event}];
    [SDRootVC() showViewController:vc sender:nil];
}

@end
