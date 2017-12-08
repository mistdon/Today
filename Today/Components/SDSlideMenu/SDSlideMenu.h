//
//  SDSlideMenu.h
//  Today
//
//  Created by shendong on 2017/12/7.
//  Copyright © 2017年 shendong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDSlideMenuItem.h"

@interface SDSlideMenu : UIControl

- (void)showMenu;

- (void)closeMenu;

- (void)addItems:(NSArray<__kindof SDSlideMenuItem *> *)items;

@end
