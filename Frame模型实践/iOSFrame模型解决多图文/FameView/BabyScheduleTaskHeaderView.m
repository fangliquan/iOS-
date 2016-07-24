//
//  BabyScheduleTaskHeaderView.m
//  wwface
//
//  Created by leo on 16/7/11.
//  Copyright © 2016年 fo. All rights reserved.
//

#import "BabyScheduleTaskHeaderView.h"
#import "AutoLinkLabel.h"
#import "BabyScheduleTaskHeaderFrame.h"
#import "ViewFrameModel.h"
#import "UIImageView+ExpandWebCache.h"

@interface BabyScheduleTaskHeaderView ()<AutoLinkLabelDelegate>

@property (nonatomic,weak)  UILabel *titleLabel;
@property (nonatomic,weak)  UILabel *fromLabel;
@property (nonatomic,weak)  UILabel *timeLabel;
@property (nonatomic,weak)  UIButton *senderBtn;

@property (nonatomic,weak)   UIImageView *coverImageView;
@property (nonatomic,weak)   AutoLinkLabel *contentLabel;
@property (nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,strong) NSMutableArray *imageDespArray;
@property (nonatomic,weak)   UIView *bottomLine;

@property (nonatomic,assign) int momentPicturesCount;

@end
@implementation BabyScheduleTaskHeaderView


- (instancetype)initWithFrame:(CGRect)frame andMomentPicturesCount:(int)momentPicturesCount
{
    _momentPicturesCount = momentPicturesCount;
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = WAWA_TEXTCOLOR_DARKGRAY;
    titleLabel.font = [UIFont boldSystemFontOfSize:WAWA_TEXTFONT_FLOAT_TITLE_BIG];
    titleLabel.numberOfLines = 0;
    self.titleLabel = titleLabel;
    [self addSubview:self.titleLabel];
    
    UILabel *fromLabel = [[UILabel alloc]init];
    fromLabel.textColor = WAWA_TEXTCOLOR_GRAY;
    fromLabel.font = [UIFont boldSystemFontOfSize:14];
    fromLabel.numberOfLines = 1;
    fromLabel.text =  @"0000";
    self.fromLabel = fromLabel;
    [self addSubview:self.fromLabel];
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor = WAWA_TEXTCOLOR_GRAY;
    self.timeLabel = timeLabel;
    [self addSubview:self.timeLabel];
    
    UIButton *senderBtn = [[UIButton alloc] init];
    //senderBtn.tag = model.senderId;
    [senderBtn addTarget:self action:@selector(senderNameClick:) forControlEvents:UIControlEventTouchUpInside];
    //[senderBtn setTitle:senderStr forState:UIControlStateNormal];
    [senderBtn setTitleColor:WAWA_COLOR_RED forState:UIControlStateNormal];
    senderBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.senderBtn = senderBtn;
    [self addSubview:self.senderBtn];
    
    
    UIImageView *picView = [[UIImageView alloc]init];
    picView.tag = 5000;
    picView.userInteractionEnabled = YES;
    [picView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture:)]];
    self.coverImageView = picView;
    [self addSubview:self.coverImageView];
    
    
    AutoLinkLabel *contentLabel = [[AutoLinkLabel alloc]init];
    contentLabel.font = [UIFont systemFontOfSize:WAWA_TEXTFONT_FLOAT_CONTENT_BIG];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = WAWA_TEXTCOLOR_DARKGRAY;
    contentLabel.aDelegate = self;
    self.contentLabel = contentLabel;
    [self addSubview:self.contentLabel];
    
    _imageArray = [NSMutableArray arrayWithCapacity:_momentPicturesCount];
    _imageDespArray = [NSMutableArray arrayWithCapacity:_momentPicturesCount];
    for (int i = 0;i< _momentPicturesCount;i++) {
        UIImageView *picView = [[UIImageView alloc]init];
        picView.tag = i;
        picView.image = [UIImage imageNamed: (@"childshow_placeholder")];
        picView.userInteractionEnabled = YES;
        [picView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture:)]];
        [_imageArray addObject:picView];
        [self addSubview:picView];
        
        AutoLinkLabel *imageDespLabel = [[AutoLinkLabel alloc]init];
        imageDespLabel.font = [UIFont systemFontOfSize:WAWA_TEXTFONT_FLOAT_CONTENT_BIG];
        imageDespLabel.textColor = WAWA_TEXTCOLOR_DARKGRAY;
        imageDespLabel.aDelegate = self;
        imageDespLabel.numberOfLines = 0;
        [_imageDespArray addObject:imageDespLabel];
        [self addSubview:imageDespLabel];
        
    }
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor lightGrayColor];
    self.bottomLine = line;
    [self addSubview:self.bottomLine];
    
}


-(void)setBabyScheduleTaskHeaderFrame:(BabyScheduleTaskHeaderFrame *)babyScheduleTaskHeaderFrame{
    _babyScheduleTaskHeaderFrame = babyScheduleTaskHeaderFrame;
    
    CGRect oldFrame = self.frame;
    if (babyScheduleTaskHeaderFrame.noticeHeaderHeight > 0) {
        oldFrame.size.height = babyScheduleTaskHeaderFrame.noticeHeaderHeight;
    }
    self.frame = oldFrame;
    
    self.titleLabel.frame = babyScheduleTaskHeaderFrame.noticeTitleF;
    self.titleLabel.text = babyScheduleTaskHeaderFrame.hedoneClassWeeklyTaskResponse.title;
    
    self.timeLabel.frame = babyScheduleTaskHeaderFrame.noticeTimeF;
    self.timeLabel.text = @"2016-07-24";
    
    self.senderBtn.frame = babyScheduleTaskHeaderFrame.noticeSenderF;
    self.senderBtn.tag = babyScheduleTaskHeaderFrame.hedoneClassWeeklyTaskResponse.senderId;
    [self.senderBtn setTitle:babyScheduleTaskHeaderFrame.hedoneClassWeeklyTaskResponse.senderName ? babyScheduleTaskHeaderFrame.hedoneClassWeeklyTaskResponse.senderName:@"" forState:UIControlStateNormal];
    
    
    self.contentLabel.frame = babyScheduleTaskHeaderFrame.noticecontentF;
    self.contentLabel.autoLinkText = babyScheduleTaskHeaderFrame.hedoneClassWeeklyTaskResponse.content;
    
    
    for (int i = 0 ; i < babyScheduleTaskHeaderFrame.hedoneClassWeeklyTaskResponse.attachs.count; i++) {
        
        UIImageView *imageView = self.imageArray[i];
        ViewFrameModel *frameModel = babyScheduleTaskHeaderFrame.noticeImagesF[i];
        imageView.frame = CGRectMake(frameModel.x, frameModel.y, frameModel.width, frameModel.height);
        //NSLog(@"image%ld, offsetY:%ld,height :%ld",i,frameModel.y,frameModel.height);
        
        AutoLinkLabel *imageDespL = self.imageDespArray[i];
        ViewFrameModel *despframeModel = babyScheduleTaskHeaderFrame.noticeImagesDespF[i];
        imageDespL.frame = CGRectMake(despframeModel.x, despframeModel.y, despframeModel.width, despframeModel.height);
        //NSLog(@"imageDesp%ld, offsetY:%ld,height :%ld",i,despframeModel.y,despframeModel.height);
        
        HedoneAttachDTO *pictureTopicPost = babyScheduleTaskHeaderFrame.hedoneClassWeeklyTaskResponse.attachs[i];
        [imageView setImageWithURLStr:pictureTopicPost.addr placeholder:[UIImage imageNamed:@"childshow_placeholder"]];
        imageDespL.autoLinkText = pictureTopicPost.desp?pictureTopicPost.desp:@"";
        
        [self.imageArray replaceObjectAtIndex:i withObject:imageView];
        [self.imageDespArray replaceObjectAtIndex:i withObject:imageDespL];
    }
    self.bottomLine.frame = babyScheduleTaskHeaderFrame.noticeFooterF;
    
}



-(void)senderNameClick:(UIButton *)sender{
    if (self.clickSenderNameBlock) {
        self.clickSenderNameBlock(self.babyScheduleTaskHeaderFrame.hedoneClassWeeklyTaskResponse.senderId);
    }
}

- (void)showPicture:(UITapGestureRecognizer *)tap {
    
    UIImageView *view = (UIImageView *)tap.view;
    if (self.lookBigNoticePictreBlock) {
        self.lookBigNoticePictreBlock(view.tag);
    }
    
    
}

#pragma mark - AutoLinkLabelDelegate

- (void)autoLinkLabel:(AutoLinkLabel *)autoLinkLabel didSelectLink:(NSString *)link withType:(AutoLinkLabelType)type{
    
    switch(type){
        case AutoLinkLabelTypeURL:
        {
            if (self.openContentWebUrlBlock) {
                self.openContentWebUrlBlock(link);
            }
        }
            break;
        case AutoLinkLabelTypePhoneNumber:
       {
//            [PXAlertView showAlertWithTitle:nil message:link cancelTitle:NSLocalizedString(@"Cancel", nil) otherTitle:NSLocalizedString(@"Call", nil) completion:^(BOOL cancelled, NSInteger buttonIndex) {
//                if (buttonIndex == 1) {
//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",link]]];
//                }
//            }];
        }
            
            break;
        case AutoLinkLabelTypeTelNumber:{
//            [PXAlertView showAlertWithTitle:nil message:link cancelTitle:NSLocalizedString(@"Cancel", nil) otherTitle:NSLocalizedString(@"Call", nil) completion:^(BOOL cancelled, NSInteger buttonIndex) {
//                if (buttonIndex == 1) {
//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",link]]];
//                }
//            }];
        }
            break;
        case AutoLinkLabelTypeEmail:
            
            break;
        default:
            
            break;
    }
    
}


@end
