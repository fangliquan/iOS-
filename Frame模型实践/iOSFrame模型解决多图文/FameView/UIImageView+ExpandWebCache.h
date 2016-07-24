//
//  UIImageView+WebCache.h
//  wwface
//
//  Created by James on 15/3/4.
//  Copyright (c) 2015年 fo. All rights reserved.
//

#import "UIImageView+WebCache.h"

@interface UIImageView (ExpandWebCache)

- (void)setImageWithURL:(NSURL *)url placeholder:(UIImage *)placeholder;

- (void)setImageWithURLStr:(NSString *)urlStr placeholder:(UIImage *)placeholder;

@end