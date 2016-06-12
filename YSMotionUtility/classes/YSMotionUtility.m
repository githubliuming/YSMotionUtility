//
//  YSMotionUtility.m
//  YSMotionUtility
//
//  Created by liuming on 16/6/12.
//  Copyright © 2016年 burning. All rights reserved.
//

#import "YSMotionUtility.h"
#import <CoreMotion/CoreMotion.h>
#import <CoreGraphics/CoreGraphics.h>
@interface YSMotionUtility ()
@property(nonatomic, strong) CMMotionManager *motionManager;
@property(nonatomic, strong) NSOperationQueue *operationQueue;
@end

@implementation YSMotionUtility

- (NSOperationQueue *)operationQueue
{
    if (_operationQueue == nil)
    {
        _operationQueue = [[NSOperationQueue alloc] init];
    }

    return _operationQueue;
}
- (instancetype)init
{
    self = [super init];

    if (self)
    {
        [self initMotionManager];
        //        [self startUpdateAccelerometer];
    }

    return self;
}

- (void)initMotionManager
{
    if (_motionManager == nil)
    {
        self.motionManager = [[CMMotionManager alloc] init];

        if (self.velocity <= 0)
        {
            self.velocity = 1.5;
        }
    }
}

- (void)startUpdateAccelerometer
{
    /* 设置采样的频率，单位是秒 */
    NSTimeInterval updateInterval = 1 / 40;
    if (self.motionManager.isAccelerometerAvailable == YES)
    {
        [self.motionManager setAccelerometerUpdateInterval:updateInterval];

        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                                 withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {

                                                     CGFloat x = accelerometerData.acceleration.x;
                                                     CGFloat y = accelerometerData.acceleration.y;
                                                     CGFloat z = accelerometerData.acceleration.z;
                                                     if (y > self.velocity)
                                                     {
                                                         NSLog(@"---x:%f ---y:%f -----z:%f ", x, y, z);
                                                     }

                                                 }];
    }
}
@end
