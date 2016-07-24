//
//  WawaOpenMenu.m
//  wwface
//
//  Created by leo on 16/1/14.
//  Copyright © 2016年 fo. All rights reserved.
//

#import "WawaOpenMenu.h"

@interface WawaOpenMenu()
{
    UIButton *button;
    UIImageView *imageView;
    UILabel *titleLabel;
}



@end

@implementation WawaOpenMenu
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup{
    self.backgroundColor = [UIColor blackColor];
    self.layer.cornerRadius = 4;
    button = [[UIButton alloc] initWithFrame:CGRectMake(5, 0, 60, 30)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blackColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2,26, 26)];
    [button addSubview:imageView];
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 5,30, 20)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor whiteColor];
    [button addSubview:titleLabel];

    [self addSubview:button];
}
- (void)updateMenuButton:(BOOL)isDelete{
    if (isDelete) {
        titleLabel.text = @"删除" ;
        button.tag = 1;
        imageView.image = [UIImage imageNamed:@"icon_delete_action"];
    }else{
        titleLabel.text = @"举报" ;
        button.tag = 2;
        imageView.image =[UIImage imageNamed:@"icon_report_action"];
    }
}

-(void)buttonClick:(UIButton *)btn{
    if (self.wawaMenuSelectedItem) {
        if (btn.tag == 1) {
            self.wawaMenuSelectedItem(YES);
        }else{
            self.wawaMenuSelectedItem(NO);
        }
    }
}


@end
