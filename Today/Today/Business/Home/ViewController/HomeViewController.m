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
#import "SDEventLayout.h"
#import "BaseTableView.h"
#import "HomeItemTableViewCell.h"

#import "WritingViewController.h"

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet BaseTableView *tableView;
@property (nonatomic) NSMutableArray<__kindof SDEventLayout *> *layoutLists;

@end

@implementation HomeViewController
- (NSMutableArray<__kindof SDEventLayout *> *)layoutLists{
    if(!_layoutLists){
        _layoutLists = [NSMutableArray new];
    }
    return _layoutLists;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
- (void)setupUI{
    [self setBackgroundImageUrl:KDefaultBackgroundImageUrl];
    self.tableView.separatorInset = UIEdgeInsetsMake(5, 5, 5, 5);
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
    
    NSArray *arr = [SDEventItem queryAllEvents];
    [self.layoutLists removeAllObjects];
    for (SDEventItem *item in arr) {
        SDEventLayout *layout = [[SDEventLayout alloc] initWithTodayEvents:item];
        [self.layoutLists addObject:layout];
    }
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// MARK: - UITableView datasource and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.layoutLists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.layout = self.layoutLists[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    WritingViewController *write = [WritingViewController new];
    WritingViewController *writing = (WritingViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WritingViewController"];
    writing.eventItem = self.layoutLists[indexPath.row].event;
    [self.navigationController showViewController:writing sender:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"row = %ld, totalHeight = %lf", indexPath.row, self.layoutLists[indexPath.row].totalHeight);
    return self.layoutLists[indexPath.row].totalHeight;
}

@end
