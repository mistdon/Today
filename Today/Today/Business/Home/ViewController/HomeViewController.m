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
#import "BaseTableView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "HomeItemTableViewCell.h"
@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet BaseTableView *tableView;
@property (nonatomic) NSMutableArray<__kindof TodayEvents *> *lists;

@end

@implementation HomeViewController
- (NSMutableArray<__kindof TodayEvents *> *)lists{
    if(!_lists){
        _lists = [NSMutableArray new];
    }
    return _lists;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroundImageUrl:KTempBackgroundUrl];
    [self configureTabbar];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeItemTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self qureyEvventLists];
}
- (void)qureyEvventLists{
//    AVQuery *query = [AVQuery queryWithClassName:@"TodayEvents"];
//    //    [query whereKey:@"gender" equalTo:@"M"]; //查询指定key值的
//    [query includeKey:@"image"];
//    NSArray *array =  [query findObjects];
//    for (Account *account in array) {
//        NSLog(@"name = %@",account.objectId);
//    }
//    NSLog(@"array = %lu",array.count);
    
    NSArray *arr = [TodayEvents queryAllEvents];

    [self.lists removeAllObjects];
    [self.lists addObjectsFromArray:arr];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// MARK: - UITableView datasource and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.lists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.todayEvents = self.lists[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150.f;
}
// MARK: - private method
- (void)configureTabbar{
    [[UINavigationBar appearance] setBarTintColor:[UIColor lightGrayColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor lightGrayColor]];
}
@end
