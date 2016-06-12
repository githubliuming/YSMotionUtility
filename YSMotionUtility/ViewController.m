//
//  ViewController.m
//  YSMotionUtility
//
//  Created by liuming on 16/6/12.
//  Copyright © 2016年 burning. All rights reserved.
//

#import "ViewController.h"
#import "YSMotionUtility.h"
@interface ViewController ()
@property(nonatomic, strong) YSMotionUtility* utility;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.utility = [[YSMotionUtility alloc] init];

    [self.utility startUpdateAccelerometer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
