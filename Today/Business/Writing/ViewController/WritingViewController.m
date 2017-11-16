//
//  WritingViewController.m
//  Today
//
//  Created by shendong on 2017/11/10.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "WritingViewController.h"
#import "SDEventItem.h"
#import "SDLocationService.h"
#import "UIImageView+SDImageManagerHelper.h"
#import <YYKit/YYKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <YYKeyboardManager/YYKeyboardManager.h>
#import <Masonry/Masonry.h>
#import "SDToast.h"

@interface WritingViewController ()<CLLocationManagerDelegate, YYKeyboardObserver, YYTextViewDelegate>
//@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic) YYTextView *textView;
@property (nonatomic) YYKeyboardManager *manager;

@end

@implementation WritingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[YYKeyboardManager defaultManager] addObserver:self];
    // Do any additional setup after loading the view.
//    [self.backgroundImageView sd_setImageWithUrlString:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(completeAction:)];
    self.navigationItem.rightBarButtonItem = done;
//    self.textView.editable = (self.eventItem == nil);
    self.textView.placeholderText = @"今天发生什么有趣的事情了?";
    self.textView.delegate = self;
    [[SDLocationService sharedSerice] requesetLocaion];
    
    if (self.eventItem) {
        self.textView.text = [self.eventItem.contents stringByAppendingString:self.eventItem.contents ];
    }
    @weakify(self);
    [RACObserve(self.textView, isEditable) subscribeNext:^(id x) {
        @strongify(self);
        
    }];
    [self setupKeyboardManager];
    [self.view addSubview:self.textView];
}
- (YYTextView *)textView{
    if(!_textView){
        _textView = [YYTextView new];
        _textView.size = CGSizeMake(self.view.size.width, self.view.size.height);
        _textView.contentInset = UIEdgeInsetsMake(12, 16, 12, 16);
        _textView.alwaysBounceVertical = YES;
//        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _textView.delegate = self;
    }
    return _textView;
}
- (void)completeAction:(id)sender{
    UIBarButtonItem *item = (UIBarButtonItem *)sender;
    item.title = self.textView.editable ? @"Done" : @"Edit";
    
    if(self.eventItem)return;
    SDEventItem *today = [SDEventItem event];
    [today setObject:@"读书" forKey:@"title"];
    [today setObject:self.textView.text forKey:@"contents"];
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"github" ofType:@"jpeg"]];
    AVFile *file = [AVFile fileWithData:data];
    [today setObject:file forKey:@"image"];
    today.tag = @"Study";
    today.group = @"Home";
    AVGeoPoint *point = [AVGeoPoint geoPointWithLatitude:39.9 longitude:116.4];
    [today setObject:point forKey:@"geoPoint"];
    [today setObject:@"上海市" forKey:@"locationStr"];
    @weakify(self);
    [today saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        @strongify(self);
        if (succeeded) {
//            [self.navigationController popViewControllerAnimated:YES];
            [SDToast success:@"success"];
        }else{
            NSLog(@"error = %@",error);
            [SDToast error:@"error"];
        };
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [[YYKeyboardManager defaultManager] removeObserver:self];
}
- (void)setupKeyboardManager{
    self.manager = [YYKeyboardManager defaultManager];
    // Get keyboard view and window
    UIView *view = self.manager .keyboardView;
    UIWindow *window = self.manager .keyboardWindow;
    
    // Get keyboard status
    BOOL visible = self.manager .keyboardVisible;
    CGRect frame = self.manager .keyboardFrame;
    frame = [self.manager  convertRect:frame toView:self.view];
    
    // Track keyboard animation
    [self.manager  addObserver:self];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)keyboardChangedWithTransition:(YYKeyboardTransition)transition {
    CGRect fromFrame = [self.manager  convertRect:transition.fromFrame toView:self.view];
    CGRect toFrame =  [self.manager  convertRect:transition.toFrame toView:self.view];
    BOOL fromVisible = transition.fromVisible;
    BOOL toVisible = transition.toVisible;
    NSTimeInterval animationDuration = transition.animationDuration;
    UIViewAnimationCurve curve = transition.animationCurve;
//      [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
//          make.bottom.equalTo(self.view).offset(toFrame.size.height);
//      }];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
@end
