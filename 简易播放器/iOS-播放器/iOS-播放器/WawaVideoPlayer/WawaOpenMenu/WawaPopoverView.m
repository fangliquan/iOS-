//
//  WawaPopoverView.m
//  wwface
//
//  Created by leo on 16/1/15.
//  Copyright © 2016年 fo. All rights reserved.
//

#import "WawaPopoverView.h"

#define kArrowHeight 10.f
#define kArrowCurvature 6.f
#define SPACE 2.f
#define ROW_HEIGHT 35
#define TITLE_FONT [UIFont systemFontOfSize:16]

//#define RGB(r, g, b)    [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]

@interface WawaPopoverView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic) CGPoint showPoint;

@property (nonatomic, strong) UIButton *handerView;



@end

@implementation WawaPopoverView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(id)initWithPoint:(CGPoint)point titles:(NSArray *)titles images:(NSArray *)images
{
    self = [super init];
    if (self) {
        self.showPoint = point;
        self.titleArray = titles;
        self.imageArray = images;
        
        self.frame = [self getViewFrame];
        [self addSubview:self.tableView];
    }
    return self;
}

-(CGRect)getViewFrame
{
    CGRect frame = CGRectZero;
    frame.size.height = ROW_HEIGHT;
    frame.size.width =  75;
    
    frame.origin.x = self.showPoint.x - frame.size.width/2;
    frame.origin.y = self.showPoint.y - CGRectGetHeight(frame)/2;
    return frame;
}


-(void)show
{
    self.handerView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_handerView setFrame:[UIScreen mainScreen].bounds];
    [_handerView setBackgroundColor:[UIColor clearColor]];
    [_handerView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_handerView addSubview:self];

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:_handerView];
    
    CGPoint arrowPoint = [self convertPoint:self.showPoint fromView:_handerView];
    self.layer.anchorPoint = CGPointMake(arrowPoint.x / self.frame.size.width, arrowPoint.y / self.frame.size.height);
    self.frame = [self getViewFrame];
    
    self.alpha = 0.f;
//    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    [UIView animateWithDuration:0.20f delay:0.f options:UIViewAnimationOptionCurveLinear animations:^{
        
        CGRect frame = self.frame;
        frame.origin.x -= CGRectGetWidth(frame)/2;
        self.frame = frame;
        
//        self.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
        self.alpha = 1.f;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dismiss
{
    [self dismiss:YES];
}

-(void)dismiss:(BOOL)animate
{
    if (!animate) {
        [_handerView removeFromSuperview];
        return;
    }
    [UIView animateWithDuration:0.3f animations:^{
//        self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        
        CGRect frame = self.frame;
        frame.origin.x += CGRectGetWidth(frame)/2;
        self.frame = frame;
        
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [_handerView removeFromSuperview];
    }];
    
}
#pragma mark - UITableView

-(UITableView *)tableView
{
    if (_tableView != nil) {
        return _tableView;
    }
    
     self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 75, ROW_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.alwaysBounceHorizontal = NO;
    _tableView.alwaysBounceVertical = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    return _tableView;
}

#pragma mark - UITableView DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titleArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WawaMenuCell *cell = [WawaMenuCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setImageAndTitle: [UIImage imageNamed:[_imageArray objectAtIndex:indexPath.row]] andTitle:[_titleArray objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.selectRowAtIndex) {
        self.selectRowAtIndex(indexPath.row);
    }
    [self dismiss:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ROW_HEIGHT;
}


@end


@interface WawaMenuCell()

@property(nonatomic,strong) UIImageView *iconView;
@property(nonatomic,strong) UILabel     *titleLable;

@end

@implementation WawaMenuCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"menuCell";
    WawaMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[WawaMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(void) setup{
    self.backgroundColor =[UIColor clearColor];
    self.contentView.backgroundColor = [UIColor blackColor];
    self.contentView.layer.cornerRadius = 4;
    UIImageView *iconView = [[UIImageView alloc] init];
    self.iconView = iconView;
    [self.contentView addSubview:iconView];
    
    
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.font = [UIFont systemFontOfSize:15];
    titleLable.textColor = [UIColor whiteColor];
    self.titleLable = titleLable;
    [self.contentView addSubview:titleLable];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(8);
        make.top.equalTo(self.contentView.mas_top).offset (5);
        make.width.equalTo(25);
        make.height.equalTo(25);
    }];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconView.mas_right).offset(2);
        make.top.equalTo(self.contentView.mas_top).offset(8);
    }];
    
}

-(void)setImageAndTitle:(UIImage *)image andTitle:(NSString *)title{
    
    self.iconView.image = image;
    self.titleLable.text = title;
    
}

@end
