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
@property(nonatomic,assign)BOOL isShake;
@property(nonatomic,assign)BOOL isOver;
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


- (instancetype) initWithtBlock:(motionBlock)block{

    self = [self init];
    if (self) {
        
        
        self.block = block;
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

        [self.motionManager startAccelerometerUpdatesToQueue:self.operationQueue
                                                 withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {

                                                     BOOL isShake = [self isShake:accelerometerData];
                                                 
                                                     if (isShake) {
                                                     
                                                         //处于摇一摇状态中
                                                         self.isOver = NO;
                                                         if (self.block) {
                                                             
                                                             BOOL isContinue = self.block();
                                                             if (isContinue) {
                                                                 
                                                                 [self. motionManager startAccelerometerUpdates];
                                                             }
                                                         }
                                                     } else {
                                                     
                                                        self.isOver = YES;
                                                     }
                                                     
                                                     if (self.isOver) {
                                                         
                                                         [self.motionManager stopAccelerometerUpdates];
                                        
                                                         // 取消队列中排队的其它请求
                                                         [self.operationQueue cancelAllOperations];
                                                         
        
                                                     }
                                                     
                                                     

                                                 }];
    }
}

- (BOOL)isShake:(CMAccelerometerData *)newestAccel {
    
    BOOL isShake = NO;
    
    // 三个方向任何一个方向的加速度大于1.5就认为是处于摇晃状态，当都小于1.5时认为摇奖结束。
    if (ABS(newestAccel.acceleration.y) > self.velocity) {
        
        isShake = YES;
        
    }
    return isShake;
    
}
@end
