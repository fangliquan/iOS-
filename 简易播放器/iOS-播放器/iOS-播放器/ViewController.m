//
//  ViewController.m
//  iOS-播放器
//
//  Created by microleo on 16/7/24.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "ViewController.h"
#import "WawaVideoPlayViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 视频播放
    WawaVideoPlayViewController *vc= [[WawaVideoPlayViewController alloc] init];
    vc.videoURL =[NSURL URLWithString:@"http://2527.vod.myqcloud.com/2527_117134a2343111e5b8f5bdca6cb9f38c.f20.mp4"];
    vc.content = @"http://2527.vod.myqcloud.com/2527_117134a2343111e5b8f5bdca6cb9f38c.f20.mp4";
    UINavigationController *rootVedioVc = [[UINavigationController alloc]initWithRootViewController:vc];
    rootVedioVc.navigationBarHidden = YES;
    [self presentViewController:rootVedioVc animated:NO completion:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
