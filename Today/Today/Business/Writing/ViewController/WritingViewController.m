//
//  WritingViewController.m
//  Today
//
//  Created by shendong on 2017/11/10.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "WritingViewController.h"
#import "TodayEvents.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <NSDate+DateTools.h>

@interface WritingViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UITextView *contentView;

@end

@implementation WritingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.ivsky.com/img/tupian/pre/201012/25/suse_zhiwen.jpg"]];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Don" style:UIBarButtonItemStyleDone target:self action:@selector(completeAction:)];
    self.navigationItem.rightBarButtonItem = done;
}

- (void)completeAction:(id)sender{
    TodayEvents *today = [TodayEvents event];
    [today setObject:@"读书" forKey:@"title"];
    [today setObject:self.contentView.text forKey:@"contents"];
    [today setObject:[NSDate date]  forKey:@"beginDate"];
    [today setObject:[[NSDate date] dateByAddingHours:8]  forKey:@"endDate"];
    today.tag = @"Study";
    today.group = @"Home";
    [today save];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
