//
//  WritingViewController.m
//  Today
//
//  Created by shendong on 2017/11/10.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "SDWritingViewController.h"
#import "SDEventLayout.h"
#import "SDLocationService.h"
#import "UIImageView+SDImageManagerHelper.h"
#import <YYKeyboardManager/YYKeyboardManager.h>
#import <Masonry/Masonry.h>
#import "SDToast.h"
#import "SDConvenientFunc.h"
#import "SDWritingToolbar.h"
#import <HXWeiboPhotoPicker/HXPhotoManager.h>
#import <HXWeiboPhotoPicker/HXPhotoViewController.h>
#import "SDSlideMenu.h"


static CGFloat const KToolBarHeight = 44;

UINavigationController * _Nonnull SDWriteNavi(SDEventItem * _Nonnull item, BOOL newPost){
    SDWritingViewController *write = [SDWritingViewController new];
    write.eventItem = item;
    return [[UINavigationController alloc] initWithRootViewController:write];
}

@interface SDWritingViewController ()<CLLocationManagerDelegate, YYTextKeyboardObserver, YYTextViewDelegate, SDLocationServiceProtocol,HXPhotoViewControllerDelegate>
@property (nonatomic) UITextField *titleTextField;
@property (nonatomic) YYTextView *textView;
@property (nonatomic) YYKeyboardManager *manager;
@property (nonatomic, strong) SDWritingToolbar *toolbar;
@property (nonatomic, assign) BOOL isInputEmoticon;
@property (nonatomic) SDLocationService *locationService;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) HXPhotoManager *photoManager;
@property (nonatomic) UIImage *selectedImage;
@property (nonatomic) NSMutableAttributedString *contentText;
@property (nonatomic) SDSlideMenu *menu;
@end

@implementation SDWritingViewController
- (NSMutableAttributedString *)contentText{
    if (!_contentText) {
        _contentText = [NSMutableAttributedString new];
    }
    return _contentText;
}
- (SDLocationService *)locationService{
    if (!_locationService) {
        _locationService = [SDLocationService new];
        _locationService.delegate = self;
    }
    return _locationService;
}
- (HXPhotoManager *)photoManager {
    if (!_photoManager) {
        _photoManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
    }
    return _photoManager;
}
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
    if (self.eventItem && !self.isNewPost) {
        self.textView.text = self.eventItem.contents;
    }else{
        self.eventItem = [SDEventItem new];
    }
//    self.navigationItem.title = self.eventItem.title.length > 0 ? self.eventItem.title : @"今日新鲜的事情了啊";
    [self sd_addLocation];
}
- (void)setupUI{
    // navigation Bar
//    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
//    [cancelItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} forState:UIControlStateNormal];
//    self.navigationItem.leftBarButtonItem = cancelItem;
//    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(completeAction:)];
//    self.navigationItem.rightBarButtonItem = done;
    //TODO: 添加标题输入项(可选)
    //text View
    [self.view addSubview:self.textView];
    
    self.menu = [[SDSlideMenu alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) - 60, CGRectGetHeight(self.view.frame) - 60, 50, 50)];
//    SDSlideMenuItem *one = [SDSlideMenuItem menui]
    [self.menu addItems:@[[SDSlideMenuItem menuWithImage:[UIImage imageNamed:@"submit_fail"]],
                          [SDSlideMenuItem menuWithImage:[UIImage imageNamed:@"submit_fail"]],
                          [SDSlideMenuItem menuWithImage:[UIImage imageNamed:@"submit_fail"]],
                          [SDSlideMenuItem menuWithImage:[UIImage imageNamed:@"submit_fail"]]]];
    [self.view addSubview:self.menu];
    
    NSLog(@"self.subviews = %@",self.view.subviews);
//    [self _initToolbar];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor yellowColor];
    btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        [self dismissViewControllerAnimated:YES completion:NULL];
        return [RACSignal empty];
    }];
    [self.view addSubview:btn];
    
    @weakify(self);
    self.toolbar.callBackBlock = ^(SDToolBarType type) {
        @strongify(self);
        switch (type) {
            case SDToolBarTypeTitle:
                [self sd_addTitle];
                break;
            case SDToolBarTypeLocation:
                [self sd_addLocation];
                break;
            case SDToolBarTypeWeather:
                [self sd_addWeather];
                break;
            case SDToolBarTypeImage:
                [self sd_addPostImage];
                break;
            default:
                break;
        }
    };
    [self.textView becomeFirstResponder];
    
}
- (YYTextView *)textView{
    if(!_textView){
        _textView = [YYTextView new];
        _textView.size = CGSizeMake(self.view.size.width, self.view.size.height);
        _textView.textContainerInset = UIEdgeInsetsMake(12, 16, 12, 16);
        _textView.contentInset = UIEdgeInsetsMake(0, 0, KToolBarHeight, 0);
        _textView.backgroundColor = [UIColor lightTextColor];
        _textView.extraAccessoryViewHeight = KToolBarHeight;
        _textView.alwaysBounceVertical = YES;
        _textView.alwaysBounceHorizontal = NO;
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _textView.delegate = self;
        _textView.inputAccessoryView = [UIView new];
        _textView.linePositionModifier = [SDEventLinePositionModifier defaultPositionModifier];
        _textView.placeholderText = @"今天发生什么有趣的事情了?";
    }
    return _textView;
}
- (void)_initToolbar {
    if (_toolbar) return;
    _toolbar = [SDWritingToolbar loadFromNib];
    _toolbar.size = CGSizeMake(self.view.width, KToolBarHeight);
    _toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    _toolbar.bottom = self.view.height;
    [self.view addSubview:_toolbar];
}
// MARK: - action handler
- (void)cancelAction:(id)sender{
    [self.textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)completeAction:(id)sender{
//    UIBarButtonItem *item = (UIBarButtonItem *)sender;
//    item.title = self.textView.editable ? @"Done" : @"Edit";
//    if(self.eventItem)return;
    SDEventItem *today = self.eventItem;
    [today setObject:[AVUser currentUser] forKey:@"owner"];
    if (self.navigationItem.title.length > 0) {
       [today setObject:self.navigationItem.title forKey:@"title"];
    }
    [today setObject:self.textView.text forKey:@"contents"];
    if (self.selectedImage) {
        NSData *data = UIImagePNGRepresentation(self.selectedImage);
        AVFile *file = [AVFile fileWithData:data];
        [today setObject:file forKey:@"image"];
    }
    today.tag = @"Study";
    today.group = @"Home";

    @weakify(self);
    [today saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        @strongify(self);
        if (succeeded) {
            [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
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
- (void)sd_addTitle{
    NSString *newTitle = @"今日是个好日子";
    self.eventItem.title = newTitle;
    self.navigationItem.title = newTitle;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add Title" message:@"Add your personal title" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Please input new title!";
    }];
    @weakify(self);
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSString *text = alert.textFields.firstObject.text;
        if (text.length == 0) {
            [SDToast message:@"Cannot be empty"];
            return ;
        }
        @strongify(self);
        self.title = text;
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        ;
    }];
    [alert addAction:action];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:NULL];
    
}
// MARK: - Tool Bar method
- (void)sd_addLocation{
    [self.locationService requesetLocaion];
}
- (void)sd_addWeather{
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"Weather" attributes:nil];
    [self.contentText appendAttributedString:att];
    self.textView.attributedText = self.contentText;
    
}
- (void)sd_addPostImage{
    HXPhotoViewController *vc = [[HXPhotoViewController alloc] init];
    vc.delegate = self;
    vc.manager = self.photoManager;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
    
}
// MARK: - SDLocationServiceProtocol
- (void)locationService:(SDLocationService *)locaservice updateLocation:(NSArray<__kindof CLPlacemark *> *)placeMarks{
    if (placeMarks.count == 0) {
        [self configureLocation:@"北京市" latitude:39.9 longtitude:116.4];
        [SDToast message:@"获取位置失败,以测试数据替代"];
        return;
    }
    CLPlacemark *mark = placeMarks.firstObject;
    NSString *place = [NSString stringWithFormat:@"%@,%@",mark.locality, mark.name];
    [self configureLocation:place latitude:mark.location.coordinate.latitude longtitude:mark.location.coordinate.longitude];
}
- (void)locationService:(SDLocationService *)locaservice failWithError:(NSError *)error{
    [SDToast message:error.localizedDescription];
}
- (void)configureLocation:(NSString *)locaion latitude:(double)latitude longtitude:(double)longtitude{
    self.eventItem.locationStr = locaion;
    AVGeoPoint *point = [AVGeoPoint geoPointWithLatitude:latitude longitude:longtitude];
    self.eventItem.geoPoint = point;
    self.toolbar.infoLabel.text = locaion;
}
// 通过 HXPhotoViewControllerDelegate 代理返回选择的图片以及视频
- (void)photoViewControllerDidNext:(NSArray *)allList Photos:(NSArray *)photos Videos:(NSArray *)videos Original:(BOOL)original{
    if (photos.count == 0)return;
    HXPhotoModel *model = photos.firstObject;
    self.selectedImage = model.thumbPhoto;
    
    UIFont *font = [UIFont systemFontOfSize:16];
    
    NSMutableAttributedString *attachment = nil;
    
    attachment = [NSMutableAttributedString yy_attachmentStringWithContent:self.selectedImage contentMode:UIViewContentModeCenter attachmentSize:self.selectedImage.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
    [self.contentText appendAttributedString: attachment];
    self.textView.attributedText = self.contentText;
}

// 点击取消
- (void)photoViewControllerDidCancel{
    
}
@end

