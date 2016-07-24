//
//  ReportCell.h
//  wwface
//
//  Created by pc on 16/6/24.
//  Copyright © 2016年 fo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportModel : NSObject

@property (nonatomic, copy) NSString * name;
@property (nonatomic, assign) int value;
@property (nonatomic, assign) BOOL selected;

@end

@interface ReportCell : UITableViewCell

@property (nonatomic, strong) UILabel * titleL;
@property (nonatomic, strong) UIImageView * imgV;

- (void)configCellWithModel:(NSObject *)model;

@end
