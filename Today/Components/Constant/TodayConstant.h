//
//  TodayConstant.h
//  Today
//
//  Created by shendong on 2017/2/21.
//  Copyright © 2017年 shendong. All rights reserved.
//

#ifndef TodayConstant_h
#define TodayConstant_h

#define RegisterAVObject \
    + (void)load{\
        [self registerSubclass];\
    }\
    + (NSString *)parseClassName{\
        return NSStringFromClass([self class]);\
    }

#endif /* TodayConstant_h */
