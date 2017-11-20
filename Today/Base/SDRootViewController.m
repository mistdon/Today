//
//  SDRootViewController.m
//  Today
//
//  Created by shendong on 2017/11/15.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "SDRootViewController.h"
#import "SDHomeViewController.h"
#import "UIColor+SDColor.h"
SDRootViewController * SDRootVC(void){
    return [SDRootViewController rootViewController];
}
@interface SDRootViewController ()

@end

@implementation SDRootViewController

+ (SDRootViewController *)rootViewController{
    return (SDRootViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
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
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}
@end
