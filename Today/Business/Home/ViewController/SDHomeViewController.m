//
//  HomeViewController.m
//  Today
//
//  Created by shendong on 2017/11/10.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "SDHomeViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "Account.h"
#import "SDEventLayout.h"
#import "BaseTableView.h"
#import "HomeItemTableViewCell.h"
#import "SDAdView.h"

#import "SDWritingViewController.h"
#import <Masonry/Masonry.h>
#import "SDToast.h"
#import "SDConvenientFunc.h"
#import "UIColor+SDColor.h"
#import <SDViewHelper/UIView+RectCorner.h>
#import "SDHomeComponent.h"
#import "SDPersonalViewController.h"

@interface SDHomeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) SDAdView *adView;
@property (nonatomic) UIButton *addButton;
@property (nonatomic) SDHomeComponent *homeComponent;
@property (nonatomic, weak) SDPersonalViewController *personalVC;
@end

@implementation SDHomeViewController
- (UIButton *)addButton{
    if (!_addButton) {
        _addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _addButton.backgroundColor = [UIColor sd_mainThemeColor];
        [_addButton setTitle:@"+" forState:UIControlStateNormal];
        [_addButton sd_cornerAll];
        [_addButton addTarget:self action:@selector(addNewItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.homeComponent = [SDHomeComponent componentWithTableView:self.tableView];
    self.navigationItem.title = @"小手记";
}
- (void)setupUI{
    [self setBackgroundImageUrl:KDefaultBackgroundImageUrl];
    
    UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleDone target:nil action:nil];
    @weakify(self);
    menu.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"menu");
        @strongify(self);
        [self showMenu];
        return [RACSignal empty];
    }];
    self.navigationItem.leftBarButtonItem = menu;
    [self.adView setupUrl:@"https://img1.doubanio.com/view/photo/m/public/p2154876548.webp"];
    [self.view addSubview:self.addButton];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.bottom.equalTo(self.view).offset(-20);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self qureyEvventLists];
}
- (void)qureyEvventLists{
    @weakify(self);
    [SDToast loading];
    [[SDEventItem queryAllCurrentUserEvents] subscribeNext:^(NSArray * _Nullable arr) {
        [SDToast dismiss];
        @strongify(self);
        if (arr.count == 0) {
            [SDToast message:@"没有日志"];
             return ;
        }
        NSMutableArray *mute = [NSMutableArray array];
        for (SDEventItem *item in arr) {
            SDEventLayout *layout = [[SDEventLayout alloc] initWithTodayEvents:item maxTextRow:3];
            [mute addObject:layout];
        };
        self.homeComponent.layoutLists = [mute copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            self.components = @[self.homeComponent];
        });
    }error:^(NSError * _Nullable error) {
        [SDToast dismiss];
        [SDToast error:error.localizedDescription];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// MARK: - private method
- (void)addNewItem:(id)sender{
    SDWritingViewController *writing = [SDWritingViewController new];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:writing];
    [self presentViewController:navi animated:YES completion:NULL];
}
- (void)showMenu{
    SDPersonalViewController *personal = [SDPersonalViewController new];
    self.personalVC = personal;
    [self addChildViewController:self.personalVC];
    personal.view.alpha = 1;
    personal.view.frame = self.view.bounds;
//    personal.view.layer.transform = self.contentViewController.view.layer.transform;
//    personal.view.superview.layer.sublayerTransform = _contentViewController.view.superview.layer.sublayerTransform;
    [self.view addSubview:personal.view];
    
}
@end
