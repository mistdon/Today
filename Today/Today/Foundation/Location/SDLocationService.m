//
//  SDLocationService.m
//  Today
//
//  Created by shendong on 2017/11/14.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import "SDLocationService.h"
@interface SDLocationService()<CLLocationManagerDelegate>
@property (nonatomic) CLLocationManager *locationManager;
@end
@implementation SDLocationService

+ (instancetype)sharedSerice{
    static SDLocationService *service;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [SDLocationService new];
    });
    return service;
}
- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 10.0f;
        [_locationManager requestWhenInUseAuthorization];
    }
    return _locationManager;
}
// MARK: - public method
- (void)requesetLocaion{
    if ([CLLocationManager locationServicesEnabled]) {//判断定位操作是否被允许
        [self.locationManager startUpdatingLocation];//开始定位
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
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //当前所在城市的坐标值
    CLLocation *currLocation = [locations lastObject];
    NSLog(@"经度=%f 纬度=%f 高度=%f", currLocation.coordinate.latitude, currLocation.coordinate.longitude, currLocation.altitude);
    //根据经纬度反向地理编译出地址信息
//    self.currentLocation.coordinate = currLocation.coordinate;
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    __weak __typeof(self) weakSelf = self;
    [geoCoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        __typeof(weakSelf) strongSelf = weakSelf;
        CLPlacemark* placeMark = placemarks.firstObject;
        NSDictionary *address = [placeMark addressDictionary];
//        strongSelf.currentLocation.country = [address objectForKey:@"Country"];
//        strongSelf.currentLocation.provience = [address objectForKey:@"State"];
//        strongSelf.currentLocation.city = [address objectForKey:@"City"];
    }];
    
}
@end
