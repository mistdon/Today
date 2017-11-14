//
//  BaseViewController.m
//  Today
//
//  Created by shendong on 2017/11/10.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "BaseViewController.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
NSString *const KTempBackgroundUrl = @"http://img.ivsky.com/img/tupian/pre/201012/25/suse_zhiwen.jpg";
@interface BaseViewController ()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@end

@implementation BaseViewController
- (UIImageView *)backgroundImageView{
    if(!_backgroundImageView){
        _backgroundImageView = [[UIImageView alloc] init];
        [self.view addSubview:_backgroundImageView];
        [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        [self.view insertSubview:_backgroundImageView atIndex:0];
    }
    return _backgroundImageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setBackgroundImageUrl:(NSString *)backgroundImageUrl{
    _backgroundImageUrl = backgroundImageUrl;
     [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:backgroundImageUrl]];
}

@end
