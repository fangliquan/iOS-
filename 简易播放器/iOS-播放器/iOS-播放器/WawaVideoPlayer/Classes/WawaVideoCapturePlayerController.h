//
//  WawaVideoCapturePlayerController.h
//  wwface
//
//  Created by leo on 16/1/11.
//  Copyright © 2016年 fo. All rights reserved.
//

@import MediaPlayer;

@interface WawaVideoCapturePlayerController : MPMoviePlayerController
/** video.view 消失 */
@property (nonatomic, copy)void(^dimissCompleteBlock)(void);
/** 进入最小化状态 */
@property (nonatomic, copy)void(^willBackOrientationPortrait)(void);
/** 进入全屏状态 */
@property (nonatomic, copy)void(^willChangeToFullscreenMode)(void);

@property (nonatomic, copy)void(^playerReadyForDisplay)(void);
/**
 *  清空本地当前音频文件
 */
@property (nonatomic, copy)void(^cleanLocalAndReloadVideo)(void);

@property (nonatomic, assign) CGRect frame;

- (void)hiddenControlView;
- (void)cancelListeningRotating;
- (void)showInWindow;
- (void)dismiss;
/**
 *  重新加载视频
 *
 *  @param videoURL 
 */
- (void)reloadLocalVideo:(NSURL *)videoURL;

/**
 *  获取视频截图
 */
+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;

@end