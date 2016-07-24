//
//  WawaVideoPlayViewController.m
//  wwface
//
//  Created by leo on 16/1/11.
//  Copyright © 2016年 fo. All rights reserved.
//

#import "WawaVideoPlayViewController.h"
#import "WawaVideoCapturePlayerController.h"
#import "AFHTTPRequestOperation.h"
#import "MBProgressHUD+Add.h"


#define VIDEO_FOLDER @"videos"
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

@interface WawaVideoPlayViewController(){
    BOOL isStart;
}
@property (nonatomic, strong) WawaVideoCapturePlayerController *videoController;

@property(nonatomic,strong)  NSString *currentVideoFile;

@end

@implementation WawaVideoPlayViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    if (isStart) {
        isStart = NO;
        [self dismissViewControllerAnimated:NO completion:nil];
    }else{
        isStart = YES;
        [self checkAndDownLoadVideoWithURL:self.videoURL andMsgContent:self.content];
    }
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
}

-(void) setVideoURL:(NSURL *)videoURL{
    if (videoURL) {
        _videoURL = videoURL;
    }
}
-(void)setContent:(NSString *)content{
    if (content) {
        _content  = content;
    }
}

- (void)playVideoWithURL:(NSURL *)url
{
    CGFloat width = Main_Screen_Width;
    WawaVideoCapturePlayerController *videoController = [[WawaVideoCapturePlayerController alloc] init];
    videoController.frame = CGRectMake(0, 0, width, Main_Screen_Height);
    __weak typeof(self)weakSelf = self;
    videoController.contentURL = url;
    videoController.cleanLocalAndReloadVideo=^(){
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:weakSelf.currentVideoFile]) {
            BOOL isDel = [fileManager removeItemAtPath:weakSelf.currentVideoFile error:nil];
            if (isDel) {
                [weakSelf downloadVideo:weakSelf.videoURL andMsgContent:weakSelf.content isOnlyDown:YES];
            }
        }
       
    };
    [videoController setDimissCompleteBlock:^{
         weakSelf.videoController = nil;
        [self dismissViewControllerAnimated:NO completion:nil];
        
    }];
    [videoController showInWindow];
    self.videoController = videoController;
}

-(void)checkAndDownLoadVideoWithURL:(NSURL *)video andMsgContent:(NSString *)content{
    if (content && content.length> 0) {
        [self downloadVideo:video andMsgContent:content isOnlyDown:NO];
    }else{
        //content 为nil时 播放本地视频
        [self playVideoWithURL:video];
    }
}

-(void)downloadVideo :(NSURL *)video andMsgContent:(NSString *)content isOnlyDown:(BOOL )isOnlyDown{
    NSString *videoPath = [self getVideoSaveFolderPathString];//文件名
    NSString *file = [videoPath stringByAppendingPathComponent:[content stringByReplacingOccurrencesOfString:@"/" withString:@"_"]];
    if (![file hasSuffix:@".mp4"]) {
        file = [file stringByAppendingString:@".mp4"];
    }
    self.currentVideoFile = file;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:file]) {
        [self createVideoFolderIfNotExist];//创建文件file
        //初始化进度条
        MBProgressHUD *HUD = [MBProgressHUD showMessag:nil toView:self.view];
        HUD.tag = 1000;
        HUD.mode = MBProgressHUDModeAnnularDeterminate;
        HUD.labelFont = [UIFont systemFontOfSize:12];
        HUD.detailsLabelText = @"正在下载...";
        HUD.detailsLabelFont = [UIFont systemFontOfSize:14];
        HUD.square = YES;
        //初始化队列
        NSOperationQueue *queue = [[NSOperationQueue alloc ]init];
        __weak typeof(self)weakSelf = self;
        //保存路径
        AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc]initWithRequest:[NSURLRequest requestWithURL:video]];
        op.outputStream = [NSOutputStream outputStreamToFileAtPath:file append:NO];
        // 根据下载量设置进度条的百分比
        [op setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            CGFloat precent = (CGFloat)totalBytesRead / totalBytesExpectedToRead;
            HUD.progress = precent;
            HUD.labelText = [NSString stringWithFormat:@"%0.0f%%",precent*100];
        }];
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            //NSLog(@"下载成功");
            [responseObject writeToFile:file atomically:YES];
            if (!isOnlyDown) {
                 [weakSelf playVideoWithURL:[NSURL fileURLWithPath:file]];
            }else{
                if (weakSelf.currentVideoFile && weakSelf.currentVideoFile.length >0) {
                    [weakSelf.videoController reloadLocalVideo:[NSURL fileURLWithPath:weakSelf.currentVideoFile]];
                }
               
            }
            
            [HUD removeFromSuperview];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //NSLog(@"下载失败");
            HUD.labelText = [NSString stringWithFormat:@"下载失败"];
            [HUD removeFromSuperview];
            if (!isOnlyDown) {
               [weakSelf dismissViewControllerAnimated:NO completion:nil];
            }
            
        }];
        //开始下载
        [queue addOperation:op];
        
    }else{
        if (!isOnlyDown) {
             [self playVideoWithURL:[NSURL fileURLWithPath:file]];
        }else{
             [self.videoController reloadLocalVideo:[NSURL fileURLWithPath:self.currentVideoFile]];
        }
       
    }

}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (NSString *)getVideoSaveFolderPathString
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    path = [path stringByAppendingPathComponent:VIDEO_FOLDER];
    
    return path;
}
- (BOOL)createVideoFolderIfNotExist
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    NSString *folderPath = [path stringByAppendingPathComponent:VIDEO_FOLDER];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:folderPath isDirectory:&isDir];
    
    if(!(isDirExist && isDir))
    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            NSLog(@"创建图片文件夹失败");
            return NO;
        }
        return YES;
    }
    return YES;
}
@end
