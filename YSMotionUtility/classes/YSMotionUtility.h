//
//  YSMotionUtility.h
//  YSMotionUtility
//
//  Created by liuming on 16/6/12.
//  Copyright © 2016年 burning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSMotionUtility : NSObject

// http://www.125135.com/452705.htm

@property(nonatomic, assign) float velocity;
- (void)startUpdateAccelerometer;
@end
