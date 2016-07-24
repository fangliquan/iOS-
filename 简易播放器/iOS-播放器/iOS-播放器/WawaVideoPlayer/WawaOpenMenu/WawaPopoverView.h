//
//  WawaPopoverView.h
//  wwface
//
//  Created by leo on 16/1/15.
//  Copyright © 2016年 fo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WawaPopoverView : UIView

-(id)initWithPoint:(CGPoint)point titles:(NSArray *)titles images:(NSArray *)images;
-(void)show;
-(void)dismiss;
-(void)dismiss:(BOOL)animated;

@property (nonatomic, copy) void (^selectRowAtIndex)(NSInteger index);

@end

@interface WawaMenuCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

-(void) setImageAndTitle:(UIImage *) image andTitle:(NSString *)title;

@end
