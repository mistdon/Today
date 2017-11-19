//
//  SDRootViewController.m
//  Today
//
//  Created by shendong on 2017/11/15.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "SDRootViewController.h"
#import "UIColor+SDColor.h"

@interface SDRootViewController ()

@end

@implementation SDRootViewController

+ (SDRootViewController *)rootViewController{
    static SDRootViewController *root;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        root = [SDRootViewController new];
    });
    return root;
}
+ (void)initialize{
    [self configureNaviBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// MARK: - private method
+ (void)configureNaviBar{
    [[UINavigationBar appearance] setBarTintColor:[UIColor sd_mainThemeColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor sd_mainThemeColor]];
}
@end
