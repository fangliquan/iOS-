//
//  WawaTouchView.h
//  wwface
//
//  Created by leo on 16/1/15.
//  Copyright © 2016年 fo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WawaTouchView : UIButton
@property (nonatomic, copy) void (^clickDeleteOrReportViewBlock)(CGPoint touchPoint);

@end
