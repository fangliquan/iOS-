//
//  ShareTypeDef.h
//  wwface
//
//  Created by xiaobin on 19/9/14.
//  Copyright (c) 2014 fo. All rights reserved.
//
typedef NS_ENUM(NSInteger, ShareType) {
    Tencent_weixin_friend,
    Tencent_weixin_monent,
    Tencent_qq_friend,
    Tencent_qq_QZone,
    Sina_weibo,
    Phone_gallery,
    Delete_record,
    App_inside_forward,
    Type_Refresh,
    Type_CopyURL,
    Type_OpenSafari
};

@interface ShareTypeDef : NSObject


@end
