//
//  WritingViewController.m
//  Today
//
//  Created by shendong on 2017/11/10.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "WritingViewController.h"
#import "SDEventLayout.h"
#import "SDLocationService.h"
#import "UIImageView+SDImageManagerHelper.h"
#import <YYKit/YYKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <YYKeyboardManager/YYKeyboardManager.h>
#import <Masonry/Masonry.h>
#import "SDToast.h"
#import "SDConvenientFunc.h"

static CGFloat const KToolBarHeight = (35 + 64);

UINavigationController *SDWriteNavi(SDEventItem *item){
    WritingViewController *write = [WritingViewController new];
    write.eventItem = item;
    return [[UINavigationController alloc] initWithRootViewController:write];
}

@interface WritingViewController ()<CLLocationManagerDelegate, YYTextKeyboardObserver, YYTextViewDelegate>
@property (nonatomic) YYTextView *textView;
@property (nonatomic) UIView *toolbar;
@property (nonatomic) YYKeyboardManager *manager;

@end

@implementation WritingViewController
- (instancetype)init{
    self = [super init];
    [[YYTextKeyboardManager defaultManager] addObserver:self];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backgroundImageUrl = KDefaultBackgroundImageUrl;
    [self setupUI];
//    self.textView.placeholderText = @"今天发生什么有趣的事情了?";
//    self.textView.delegate = self;
//    [[SDLocationService sharedSerice] requesetLocaion];
//
    if (self.eventItem) {
        self.textView.text = [self.eventItem.contents stringByAppendingString:self.eventItem.contents];
    }
    self.navigationItem.title = self.eventItem.title.length > 0 ? self.eventItem.title : @"写入你的故事。。。";
}
- (void)setupUI{
    // navigation Bar
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
    [cancelItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = cancelItem;
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(completeAction:)];
    self.navigationItem.rightBarButtonItem = done;
    //text View
    [self.view addSubview:self.textView];
    
}
- (YYTextView *)textView{
    if(!_textView){
        _textView = [YYTextView new];
        _textView.size = CGSizeMake(self.view.size.width, self.view.size.height);
        _textView.textContainerInset = UIEdgeInsetsMake(12, 16, 12, 16);
        _textView.contentInset = UIEdgeInsetsMake(0, 0, KToolBarHeight, 0);
        _textView.backgroundColor = [UIColor lightTextColor];
        _textView.alwaysBounceVertical = YES;
        _textView.alwaysBounceHorizontal = NO;
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _textView.delegate = self;
        _textView.inputAccessoryView = [UIView new];
        _textView.linePositionModifier = [SDEventLinePositionModifier defaultPositionModifier];
    }
    return _textView;
}
- (void)_initToolbar {
    if (_toolbar) return;
    _toolbar = [UIView new];
    _toolbar.backgroundColor = [UIColor orangeColor];
    _toolbar.size = CGSizeMake(self.view.width, KToolBarHeight);
    _toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _toolbar.bottom = self.view.height;
    [self.view addSubview:_toolbar];
}
- (void)cancelAction:(id)sender{
    [self.textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)completeAction:(id)sender{
//    UIBarButtonItem *item = (UIBarButtonItem *)sender;
//    item.title = self.textView.editable ? @"Done" : @"Edit";
//    if(self.eventItem)return;
//    SDEventItem *today = [SDEventItem event];
//    [today setObject:@"读书" forKey:@"title"];
//    [today setObject:self.textView.text forKey:@"contents"];
//    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"github" ofType:@"jpeg"]];
//    AVFile *file = [AVFile fileWithData:data];
//    [today setObject:file forKey:@"image"];
//    today.tag = @"Study";
//    today.group = @"Home";
//    AVGeoPoint *point = [AVGeoPoint geoPointWithLatitude:39.9 longitude:116.4];
//    [today setObject:point forKey:@"geoPoint"];
//    [today setObject:@"上海市" forKey:@"locationStr"];
//    @weakify(self);
//    [today saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        @strongify(self);
//        if (succeeded) {
////            [self.navigationController popViewControllerAnimated:YES];
//            [SDToast success:@"success"];
//        }else{
//            NSLog(@"error = %@",error);
//            [SDToast error:@"error"];
//        };
//    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [[YYTextKeyboardManager defaultManager] removeObserver:self];
}
// MARK: - YYTextKeyboardObserver
- (void)keyboardChangedWithTransition:(YYTextKeyboardTransition)transition {
    CGRect toFrame = [[YYTextKeyboardManager defaultManager] convertRect:transition.toFrame toView:self.view];
    if (transition.animationDuration == 0) {
        _toolbar.bottom = CGRectGetMinY(toFrame);
    } else {
        [UIView animateWithDuration:transition.animationDuration delay:0 options:transition.animationOption | UIViewAnimationOptionBeginFromCurrentState animations:^{
            _toolbar.bottom = CGRectGetMinY(toFrame);
        } completion:NULL];
    }
}
// MARK: - YYTextVuewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
@end

