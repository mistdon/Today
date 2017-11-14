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
#import <CoreLocation/CoreLocation.h>
#import "SDLocationService.h"


@interface WritingViewController ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UITextView *contentView;
@property (nonatomic) CLLocationManager *locationManager;
@end

@implementation WritingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.ivsky.com/img/tupian/pre/201012/25/suse_zhiwen.jpg"]];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(completeAction:)];
    self.navigationItem.rightBarButtonItem = done;
//    [self startLocation];
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

- (void)startLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        //        CLog(@"--------开始定位");
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        //控制定位精度,越高耗电量越
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        // 总是授权
        [self.locationManager requestAlwaysAuthorization];
        self.locationManager.distanceFilter = 10.0f;
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
//        CLog(@"访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
//        CLog(@"无法获取位置信息");
    }
}
//定位代理经纬度回调
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = locations[0];
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            NSLog(@"city = %@", city);
            
//            [self httpGetWeather:city];
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    
}
@end
