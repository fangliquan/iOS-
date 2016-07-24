//
//  WawaTouchView.m
//  wwface
//
//  Created by leo on 16/1/15.
//  Copyright © 2016年 fo. All rights reserved.
//

#import "WawaTouchView.h"


@implementation WawaTouchView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)layoutSubviews{
    UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 23, 0, 20, 20)];
    imageView.image = [UIImage imageNamed:@"icon_list_more"];
    [self addSubview:imageView];
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for(UITouch *touch in event.allTouches) {
        [self logTouchInfo:touch];
        break;
    }
}

- (void)logTouchInfo:(UITouch *)touch {
    CGPoint locInWin = [touch locationInView:nil];
    
    CGPoint selfLoacal = [touch locationInView:self];
    
    if (self.clickDeleteOrReportViewBlock) {
        
        NSLog(@"x : %f   y : %f", selfLoacal.x, selfLoacal.y);
        
        CGFloat offsetY = locInWin.y - selfLoacal.y + 10;
        CGFloat offsetX = locInWin.x - selfLoacal.x;
        
        self.clickDeleteOrReportViewBlock(CGPointMake(offsetX, offsetY));
    }
}

@end
