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
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SDToast.h"

#import <SDViewHelper/UIViewController+VCLoader.h>

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
    [self qureyEvventLists];
}
- (void)setupUI{
    [self setBackgroundImageUrl:KDefaultBackgroundImageUrl];
    self.tableView.separatorInset = UIEdgeInsetsMake(5, 5, 5, 5);
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeItemTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
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
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @strongify(self);
        NSArray *arr = [SDEventItem queryAllEvents];
        [self.layoutLists removeAllObjects];
        for (SDEventItem *item in arr) {
            SDEventLayout *layout = [[SDEventLayout alloc] initWithTodayEvents:item maxTextRow:3];
            
            [self.layoutLists addObject:layout];
        };
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            [self.tableView reloadData];
        });
    });
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
    WritingViewController *writing = (WritingViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WritingViewController"];
    writing.eventItem = self.layoutLists[indexPath.row].event;
    [self.navigationController showViewController:writing sender:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"row = %ld, totalHeight = %lf", indexPath.row, self.layoutLists[indexPath.row].totalHeight);
    return self.layoutLists[indexPath.row].totalHeight;
}
- (IBAction)settingActioon:(id)sender {
    UIViewController *vc = [UIViewController sd_viewController:@"SDLoginViewController" inStoryboard:@"Login" arguments:nil];
    [self presentViewController:vc animated:YES completion:NULL];
}
@end
