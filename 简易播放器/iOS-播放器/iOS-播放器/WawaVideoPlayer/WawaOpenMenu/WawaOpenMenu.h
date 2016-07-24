//
//  WawaOpenMenu.h
//  wwface
//
//  Created by leo on 16/1/14.
//  Copyright © 2016年 fo. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^WawaMenuSelectedItem)(BOOL isDelete);

@interface WawaOpenMenu : UIView

- (void)updateMenuButton:(BOOL)isDelete;

@property(nonatomic,copy) WawaMenuSelectedItem wawaMenuSelectedItem;

@end
