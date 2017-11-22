//
//  SDLocationService.h
//  Today
//
//  Created by shendong on 2017/11/14.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN
@class SDLocationService;
@protocol SDLocationServiceProtocol<NSObject>

- (void)locationService:(SDLocationService *)locaservice updateLocation:(NSArray<__kindof CLPlacemark *> *)placeMarks;
- (void)locationService:(SDLocationService *)locaservice failWithError:(NSError *)error;

@end

@interface SDLocationService : NSObject

@property (nonatomic, weak) id<SDLocationServiceProtocol> delegate;

- (void)requesetLocaion;

@end

NS_ASSUME_NONNULL_END
