//
//  SDPersonalViewController.m
//  Today
//
//  Created by shendong on 2017/11/23.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "SDPersonalViewController.h"
#import "SDPersonalComponent.h"
@interface SDPersonalViewController ()
@property (nonatomic) SDPersonalComponent *personalComponent;
@end

@implementation SDPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.personalComponent = [SDPersonalComponent componentWithTableView:self.tableView];
    // Do any additional setup after loading the view.
    self.components = @[self.personalComponent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
