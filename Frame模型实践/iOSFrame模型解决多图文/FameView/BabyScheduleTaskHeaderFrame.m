//
//  BabyScheduleTaskHeaderFrame.m
//  wwface
//
//  Created by leo on 16/7/11.
//  Copyright © 2016年 fo. All rights reserved.
//

#import "BabyScheduleTaskHeaderFrame.h"
#import "ViewFrameModel.h"
#import "SDWebImageManager.h"

@implementation BabyScheduleTaskHeaderFrame


-(void)setHedoneClassWeeklyTaskResponse:(HedoneClassWeeklyTaskResponse *)hedoneClassWeeklyTaskResponse{
    _hedoneClassWeeklyTaskResponse = hedoneClassWeeklyTaskResponse;
    
    CGFloat topAndBottomMargin = 5.0;
    
    CGFloat rightAndLeftMargin = 8.0;
    
    CGFloat headerW = Main_Screen_Width;
    
    CGFloat contentWidth = headerW - 2*rightAndLeftMargin;
    
    CGFloat titleHeight = [BabyScheduleTaskHeaderFrame textFrameWithString:hedoneClassWeeklyTaskResponse.title width:contentWidth fontSize:WAWA_TEXTFONT_FLOAT_TITLE_BIG].height + 2;
    
    _noticeTitleF = CGRectMake(rightAndLeftMargin, topAndBottomMargin*2, contentWidth, titleHeight);
    
    
    _noticeTypeF = CGRectMake(rightAndLeftMargin, CGRectGetMaxY(_noticeTitleF) +topAndBottomMargin, contentWidth, 0.0001);
    
    
    NSString *timeStr = @"2016-07-24";
    CGSize timeLabelSize = [BabyScheduleTaskHeaderFrame textFrameWithString:timeStr width:200 fontSize:12];
    _noticeTimeF = CGRectMake(rightAndLeftMargin, CGRectGetMaxY(_noticeTypeF) + topAndBottomMargin, timeLabelSize.width, 15);
    
    NSString *senderStr = hedoneClassWeeklyTaskResponse.senderName ? hedoneClassWeeklyTaskResponse.senderName:@"";
    CGFloat senderStrW = [BabyScheduleTaskHeaderFrame textFrameWithString:senderStr width:headerW - CGRectGetMaxX(_noticeTimeF) -15 fontSize:13].width + 10;
    
    _noticeSenderF = CGRectMake(CGRectGetMaxX(_noticeTimeF), CGRectGetMaxY(_noticeTypeF) + topAndBottomMargin,senderStrW, 15);
    
   
    
    CGFloat contentH = [BabyScheduleTaskHeaderFrame textFrameWithString:hedoneClassWeeklyTaskResponse.content width:contentWidth fontSize:WAWA_TEXTFONT_FLOAT_TITLE].height + 2;
    _noticecontentF = CGRectMake(rightAndLeftMargin, CGRectGetMaxY(_noticeSenderF) + topAndBottomMargin,contentWidth, contentH);
    
    if (hedoneClassWeeklyTaskResponse.attachs && hedoneClassWeeklyTaskResponse.attachs.count > 0) {
        NSMutableArray *imagesF = [NSMutableArray arrayWithCapacity:hedoneClassWeeklyTaskResponse.attachs.count];
        NSMutableArray *imagesDespF = [NSMutableArray arrayWithCapacity:hedoneClassWeeklyTaskResponse.attachs.count];
        
        CGFloat offsetY = CGRectGetMaxY(_noticecontentF) + topAndBottomMargin;
        CGFloat upImageDespH = 0.0;
        
        //init Frame
        for (int i = 0 ; i <hedoneClassWeeklyTaskResponse.attachs.count; i++) {
            
            HedoneAttachDTO *pictureTopicPost = hedoneClassWeeklyTaskResponse.attachs[i];
            
            ViewFrameModel *imageRect = [[ViewFrameModel alloc]init];
            imageRect.x = rightAndLeftMargin;
            imageRect.y = offsetY + upImageDespH;
            imageRect.width = contentWidth;
            imageRect.height = 300;
            [imagesF addObject:imageRect];
            
            CGFloat imageDespH = [BabyScheduleTaskHeaderFrame textFrameWithString:pictureTopicPost.desp width:contentWidth fontSize:WAWA_TEXTFONT_FLOAT_TITLE].height + 2;
            ViewFrameModel *imageDespRect = [[ViewFrameModel alloc]init];
            imageDespRect.x = rightAndLeftMargin;
            imageDespRect.y = offsetY + upImageDespH + 300;
            imageDespRect.width = contentWidth;
            imageDespRect.height = imageDespH;
            [imagesDespF addObject:imageDespRect];
            upImageDespH += (imageDespH +topAndBottomMargin + 300);
        }
        _noticeImagesF = imagesF;
        _noticeImagesDespF = imagesDespF;
        
        ViewFrameModel *firstimageDespNF = [_noticeImagesDespF lastObject];
        CGRect firstimageDespCGRect = CGRectMake(firstimageDespNF.x, firstimageDespNF.y, firstimageDespNF.width, firstimageDespNF.height);
        
        _noticeFooterF = CGRectMake(0, CGRectGetMaxY(firstimageDespCGRect) + topAndBottomMargin *4, Main_Screen_Width, 1);
        
        _noticeHeaderHeight = CGRectGetMaxY(_noticeFooterF);
        if (self.reloadNoticeHeaderFrameBlock) {
            self.reloadNoticeHeaderFrameBlock();
        }
        //updateFrame
        for (int i = 0 ; i <hedoneClassWeeklyTaskResponse.attachs.count; i++) {
            
            HedoneAttachDTO *pictureTopicPost = hedoneClassWeeklyTaskResponse.attachs[i];
            [self getClassWeeklyTaskAttachPictureFrame:pictureTopicPost andIndex:i completion:^(NSInteger index, CGFloat imageH){
                
                NSMutableArray *imagesOldF = [NSMutableArray arrayWithArray:_noticeImagesF];
                NSMutableArray *imagesDespOldF = [NSMutableArray arrayWithArray:_noticeImagesDespF];
                //更新imageHeight
                ViewFrameModel *pictureF = imagesOldF [index];
                pictureF.height = imageH;
                [imagesOldF replaceObjectAtIndex:index withObject:pictureF];
                
                
                ViewFrameModel *oldpictureFM = [imagesOldF firstObject];
                CGRect oldpictureR = CGRectMake(oldpictureFM.x, oldpictureFM.y, oldpictureFM.width, oldpictureFM.height);
                
                ViewFrameModel *oldpictureDespFM = [imagesDespOldF firstObject];
                oldpictureDespFM.y = CGRectGetMaxY(oldpictureR) + topAndBottomMargin;
                [imagesDespOldF replaceObjectAtIndex:0 withObject:oldpictureDespFM];
                
                CGFloat oldOffsetY = offsetY + oldpictureFM.height + topAndBottomMargin + oldpictureDespFM.height + topAndBottomMargin;
                
                for (int m = 1; m <imagesOldF.count; m++) {
                    
                    oldOffsetY = oldOffsetY;
                    ViewFrameModel *uppictureF = imagesOldF [m];
                    uppictureF.y = oldOffsetY;
                    [imagesOldF replaceObjectAtIndex:m withObject:uppictureF];
                    
                    
                    
                    oldOffsetY = oldOffsetY + uppictureF.height + topAndBottomMargin;
                    ViewFrameModel *uppictureDespF = imagesDespOldF [m];
                    uppictureDespF.y = oldOffsetY;
                    [imagesDespOldF replaceObjectAtIndex:m withObject:uppictureDespF];
                    
                    oldOffsetY = oldOffsetY + uppictureDespF.height + topAndBottomMargin;
                    
                    
                }
                _noticeFooterF = CGRectMake(0, oldOffsetY + topAndBottomMargin*4, Main_Screen_Width, 1);
                _noticeHeaderHeight = CGRectGetMaxY(_noticeFooterF);
                
                _noticeImagesF = imagesOldF;
                _noticeImagesDespF = imagesDespOldF;
                
                
                if (self.reloadNoticeHeaderFrameBlock) {
                    self.reloadNoticeHeaderFrameBlock();
                }
            }];
        }
        
    }else{
        _noticeFooterF = CGRectMake(0, CGRectGetMaxY(_noticecontentF) + topAndBottomMargin *4, Main_Screen_Width, 1);
        
        _noticeHeaderHeight = CGRectGetMaxY(_noticeFooterF);
        if (self.reloadNoticeHeaderFrameBlock) {
            self.reloadNoticeHeaderFrameBlock();
        }
    }
    
    
    
}

- (void)getClassWeeklyTaskAttachPictureFrame:(HedoneAttachDTO*)picture andIndex:(NSInteger)index completion:(void (^)(NSInteger,CGFloat))completion {
    
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:picture.addr] options:SDWebImageRetryFailed | SDWebImageLowPriority progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    CGFloat imageH = image ? image.size.height*(Main_Screen_Width - 2*8 -4)/image.size.width : 0.000001;
                    completion(index,imageH);
                }
            });
        }
    }];
}


+ (CGFloat)textOfAlineHeightWithFontSize:(NSInteger)fontSize
{
    return [BabyScheduleTaskHeaderFrame textFrameWithString:@"测试" width:Main_Screen_Width fontSize:fontSize].height;
}


+(CGSize)textFrameWithString:(NSString *)text width:(float)width fontSize:(NSInteger)fontSize
{
    NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    // 根据第一个参数的文本内容，使用280*float最大值的大小，使用系统14号字，返回一个真实的frame size : (280*xxx)!!
    CGRect frame = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return frame.size;
}



@end
