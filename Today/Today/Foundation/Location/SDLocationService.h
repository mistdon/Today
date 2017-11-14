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

@interface SDLocationService : NSObject

@property (nonatomic, copy) NSString* country;
@property (nonatomic, copy) NSString* provience;
@property (nonatomic, copy) NSString* city;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

+ (instancetype)sharedSerice;

- (void)requesetLocaion;

@end

NS_ASSUME_NONNULL_END
