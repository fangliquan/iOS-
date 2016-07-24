//
//  BabyScheduleTaskHeaderView.h
//  wwface
//
//  Created by leo on 16/7/11.
//  Copyright © 2016年 fo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BabyScheduleTaskHeaderFrame;

@interface BabyScheduleTaskHeaderView : UIView

@property(nonatomic,strong) BabyScheduleTaskHeaderFrame *babyScheduleTaskHeaderFrame;

- (instancetype)initWithFrame:(CGRect)frame andMomentPicturesCount:(int)momentPicturesCount;

@property(nonatomic,copy)void (^clickSenderNameBlock)(long long userId);
@property(nonatomic,copy)void (^lookBigNoticePictreBlock)(NSInteger pictureIndex);
@property(nonatomic,copy)void (^openContentWebUrlBlock)(NSString *webUrl);


@end
