//
//  SDRootViewController.h
//  Today
//
//  Created by shendong on 2017/11/15.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDViewHelper/UIViewController+VCLoader.h>

@class SDRootViewController;

FOUNDATION_EXPORT SDRootViewController *SDRootVC(void);

@interface SDRootViewController : UINavigationController

+ (SDRootViewController *)rootViewController;

@end
