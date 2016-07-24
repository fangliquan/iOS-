//
//  BabyScheduleTaskHeaderFrame.h
//  wwface
//
//  Created by leo on 16/7/11.
//  Copyright © 2016年 fo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HedoneClassWeeklyTaskResponse.h"

#define WAWA_TEXTCOLOR_DARKGRAY [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]
#define WAWA_TEXTCOLOR_GRAY [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]
#define WAWA_COLOR_RED [UIColor colorWithRed:248/255.0 green:102/255.0 blue:66/255.0 alpha:1]

#define WAWA_TEXTFONT_FLOAT_TITLE   15
#define WAWA_TEXTFONT_FLOAT_TITLE_BIG   17
#define WAWA_TEXTFONT_FLOAT_CONTENT 13
#define WAWA_TEXTFONT_FLOAT_CONTENT_BIG 15
#define WAWA_TEXTFONT_FLOAT_SMALL   11


#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

@interface BabyScheduleTaskHeaderFrame : NSObject
@property(nonatomic,strong) HedoneClassWeeklyTaskResponse *hedoneClassWeeklyTaskResponse;

@property(nonatomic ,assign ,readonly) CGRect noticeTitleF;
@property(nonatomic ,assign ,readonly) CGRect noticeTypeF;
@property(nonatomic ,assign ,readonly) CGRect noticeTimeF;
@property(nonatomic ,assign ,readonly) CGRect noticeSenderF;
@property(nonatomic ,assign ,readonly) CGRect noticecontentF;
@property(nonatomic ,strong ,readonly) NSArray *noticeImagesF;
@property(nonatomic ,strong ,readonly) NSArray *noticeImagesDespF;

@property(nonatomic ,assign ,readonly) CGRect noticeFooterF;
@property(nonatomic ,assign ,readonly) CGFloat noticeHeaderHeight;

@property(nonatomic,copy)void (^reloadNoticeHeaderFrameBlock)(void);

+ (CGFloat)textOfAlineHeightWithFontSize:(NSInteger)fontSize;
+ (CGSize)textFrameWithString:(NSString *)text width:(float)width fontSize:(NSInteger)fontSize;

@end
