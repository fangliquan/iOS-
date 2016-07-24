//
//  ReportCell.m
//  wwface
//
//  Created by pc on 16/6/24.
//  Copyright © 2016年 fo. All rights reserved.
//

#import "ReportCell.h"

@implementation ReportModel

@end

@implementation ReportCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    self.titleL = [[UILabel alloc] init];
    self.titleL.font = WAWA_TEXTFONT_(15);
    self.titleL.textColor = WAWA_TEXTCOLOR_DARKGRAY;
    [self.contentView addSubview:self.titleL];
    
    self.imgV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgV];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.imgV.mas_left).offset(-5);
    }];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-15);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
}

- (void)configCellWithModel:(NSObject *)model
{
    ReportModel * dto = (ReportModel *)model;
    self.titleL.text = dto.name.length ? dto.name : @"";
    self.imgV.image = UIImageName(dto.selected ? @"CellGreenSelected" : @"CellGraySelected");
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
