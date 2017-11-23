//
//  SDPersonalComponent.m
//  Today
//
//  Created by shendong on 2017/11/23.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "SDPersonalComponent.h"

@implementation SDPersonalComponent
- (void)registerWithTableView:(UITableView *)tableView{
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:self.cellIdentifier];
}
- (NSInteger)numberOfItems{
    return 5;
}

- (__kindof UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    return cell;
}

@end
