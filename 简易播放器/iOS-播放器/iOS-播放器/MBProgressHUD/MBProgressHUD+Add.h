//
//  MBProgressHUD+Add.h
//  视频客户端
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Add)
+ (void)showError:(NSString *)error toView:(UIView *)view hideDelay:(NSTimeInterval)delay;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view hideDelay:(NSTimeInterval)delay;

+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view;
+ (void)showTextMessag:(NSString *)message toView:(UIView *)view;
+ (void)showTextMessag:(NSString *)message withWidth:(CGFloat)width toView:(UIView *)view;

+ (void)showMessage:(NSString *)message toView:(UIView *)view;

+(CGSize)textFrameWithString:(NSString *)text width:(float)width fontSize:(NSInteger)fontSize;

@end
