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

- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 10.0f;
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager requestAlwaysAuthorization];
    }
    return _locationManager;
}
// MARK: - public method
- (void)requesetLocaion{
    if ([CLLocationManager locationServicesEnabled]) {//判断定位操作是否被允许
        [self.locationManager startUpdatingLocation];//开始定位
    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //当前所在城市的坐标值
    CLLocation *currLocation = [locations lastObject];
    NSLog(@"经度=%f 纬度=%f 高度=%f", currLocation.coordinate.latitude, currLocation.coordinate.longitude, currLocation.altitude);
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    __weak __typeof(self) weakSelf = self;
    [geoCoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        __typeof(weakSelf) strongSelf = weakSelf;
        if (self.delegate && [self.delegate respondsToSelector:@selector(locationService:updateLocation:)]) {
            [self.delegate locationService:self updateLocation:placemarks];
        }
        [strongSelf.locationManager stopUpdatingLocation];
    }];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if (self.delegate && [self.delegate respondsToSelector:@selector(locationService:failWithError:)]) {
        [self.delegate locationService:self failWithError:error];
    }
}
@end
