//
//  SDEventDetailViewController.m
//  Today
//
//  Created by shendong on 2017/11/23.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "SDEventDetailViewController.h"
#import "SDWritingViewController.h"
@interface SDEventDetailViewController ()
@property (nonatomic) YYTextView *textView;
@end

@implementation SDEventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleDone target:self action:@selector(completeAction:)];
    self.navigationItem.rightBarButtonItem = done;
    [self.view addSubview:self.textView];
    self.title = self.item.title;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    @weakify(self);
    [[SDEventItem queryEventItemById:self.item.objectId] subscribeNext:^(SDEventItem * _Nullable x) {
        @strongify(self);
        self.textView.text = x.contents;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (YYTextView *)textView{
    if(!_textView){
        _textView = [YYTextView new];
        _textView.size = CGSizeMake(self.view.size.width, self.view.size.height);
        _textView.textContainerInset = UIEdgeInsetsMake(12, 16, 12, 16);
        _textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _textView.backgroundColor = [UIColor lightTextColor];
        _textView.alwaysBounceVertical = YES;
        _textView.alwaysBounceHorizontal = NO;
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _textView.inputAccessoryView = [UIView new];
        _textView.linePositionModifier = [SDEventLinePositionModifier defaultPositionModifier];
        _textView.editable = NO;
        _textView.text = self.item.contents;
    }
    return _textView;
}
- (void)completeAction:(id)sender{
    [self presentViewController:SDWriteNavi(self.item, YES) animated:NO completion:NULL];
}
@end
