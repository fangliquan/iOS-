//
//  MBProgressHUD+Add.m
//  视频客户端
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+Add.h"

@implementation MBProgressHUD (Add)

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view hideDelay:(NSTimeInterval)delay
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.minSize = CGSizeMake(100, 100);
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:delay];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view hideDelay:(NSTimeInterval)delay{
    [self show:error icon:@"error.png" view:view hideDelay:delay];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view hideDelay:(NSTimeInterval)delay
{
    [self show:success icon:@"success.png" view:view hideDelay:delay];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    return hud;
}

#pragma mark 显示一些信息
+ (void)showTextMessag:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    //设置一个高度自适应的UILabel
    CGSize size = [MBProgressHUD textFrameWithString:message width:260 fontSize:15];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, size.height)];
    label.text = message;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    hud.customView = label;
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 3秒之后再消失
    [hud hide:YES afterDelay:3];
}
+ (void)showTextMessag:(NSString *)message withWidth:(CGFloat)width toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    //设置一个高度自适应的UILabel
    CGSize size = [MBProgressHUD textFrameWithString:message width:width-20 fontSize:15];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, size.height)];
    label.text = message;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    hud.customView = label;
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 3秒之后再消失
    [hud hide:YES afterDelay:3];
}

+ (void)showMessage:(NSString *)message toView:(UIView *)view{
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.margin = 10.f;
    hud.mode = MBProgressHUDModeText;
    
    [hud hide:YES afterDelay:1];
        
}


+(CGSize)textFrameWithString:(NSString *)text width:(float)width fontSize:(NSInteger)fontSize
{
    NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    // 根据第一个参数的文本内容，使用280*float最大值的大小，使用系统14号字，返回一个真实的frame size : (280*xxx)!!
    CGRect frame = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return frame.size;
}


@end
