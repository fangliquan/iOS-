//
//  MyLabel.h
//  MyLabel
//
//  Created by James on 14/11/4.
//  Copyright (c) 2014年 pc. All rights reserved.
//

#import "TTTAttributedLabel.h"

typedef NS_OPTIONS(NSUInteger, AutoLinkLabelType) {
    AutoLinkLabelTypeURL = 0,
    AutoLinkLabelTypePhoneNumber,
    AutoLinkLabelTypeEmail,
    AutoLinkLabelTypeAt,
    AutoLinkLabelTypePoundSign,
    AutoLinkLabelTypeTelNumber,
};

@class AutoLinkLabel;

@protocol AutoLinkLabelDelegate <NSObject>

@optional

- (void)autoLinkLabel:(AutoLinkLabel *)autoLinkLabel didSelectLink:(NSString *)link withType:(AutoLinkLabelType)type;

@end

@interface AutoLinkLabel : TTTAttributedLabel

@property(nonatomic,copy)NSString *autoLinkText;

@property (nonatomic, assign) id<AutoLinkLabelDelegate> aDelegate;

@end
