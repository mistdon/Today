//
//  HomeViewController.m
//  Today
//
//  Created by shendong on 2017/11/10.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "HomeViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "Account.h"
#import "TodayEvents.h"

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *models;
@end

@implementation HomeViewController
- (NSMutableArray *)models{
    if (!_models) {
        _models = [NSMutableArray new];
    }
    return _models;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTabbar];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self qureyEvventLists];
}
- (void)qureyEvventLists{
    AVQuery *query = [AVQuery queryWithClassName:@"TodayEvents"];
    //    [query whereKey:@"gender" equalTo:@"M"]; //查询指定key值的
    NSArray *array =  [query findObjects];
    for (Account *account in array) {
        NSLog(@"name = %@",account.objectId);
    }
    NSLog(@"array = %lu",array.count);
    [self.models removeAllObjects];
    [self.models addObjectsFromArray:array];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// MARK: - UITableView datasource and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    TodayEvents *today = self.models[indexPath.row];
    cell.textLabel.text = today.contents;
    return cell;
}
// MARK: - private method
- (void)configureTabbar{
    [[UINavigationBar appearance] setBarTintColor:[UIColor lightGrayColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor lightGrayColor]];
}
@end
