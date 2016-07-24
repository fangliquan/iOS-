//
//  UIImageView+WebCache.m
//  wwface
//
//  Created by James on 15/3/4.
//  Copyright (c) 2015年 fo. All rights reserved.
//

#import "UIImageView+ExpandWebCache.h"

@implementation UIImageView (ExpandWebCache)

- (void)setImageWithURL:(NSURL *)url placeholder:(UIImage *)placeholder
{
    [self sd_setImageWithURL:url placeholderImage:placeholder options:SDWebImageRetryFailed | SDWebImageLowPriority];
}

- (void)setImageWithURLStr:(NSString *)urlStr placeholder:(UIImage *)placeholder
{
    [self setImageWithURL:[NSURL URLWithString:urlStr] placeholder:placeholder];
}

@end
