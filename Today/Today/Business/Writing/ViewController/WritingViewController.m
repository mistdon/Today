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
#import "SDLocationService.h"


@interface WritingViewController ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UITextView *contentView;

@end

@implementation WritingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.ivsky.com/img/tupian/pre/201012/25/suse_zhiwen.jpg"]];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(completeAction:)];
    self.navigationItem.rightBarButtonItem = done;

    [[SDLocationService sharedSerice] requesetLocaion];
}

- (void)completeAction:(id)sender{
    TodayEvents *today = [TodayEvents event];
    [today setObject:@"读书" forKey:@"title"];
    [today setObject:self.contentView.text forKey:@"contents"];
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"github" ofType:@"jpeg"]];
    AVFile *file = [AVFile fileWithData:data];
    [today setObject:file forKey:@"image"];
    today.tag = @"Study";
    today.group = @"Home";
    AVGeoPoint *point = [AVGeoPoint geoPointWithLatitude:39.9 longitude:116.4];
    [today setObject:point forKey:@"geoPoint"];
    [today setObject:@"上海市" forKey:@"locationStr"];
    [today saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            NSLog(@"error = %@",error);
        };
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
