//
//  ReportViewController.h
//  wwface
//
//  Created by pc on 16/6/24.
//  Copyright © 2016年 fo. All rights reserved.
//

#import "BaseTableViewController.h"

typedef NS_ENUM(NSInteger, ReportType) {
    ReportType_BabyShow = 1,
    ReportType_BabyShowReply,
    ReportType_Topic,
    ReportType_TopicReply,
    ReportType_TeacherConsulting
};

@interface ReportViewController : BaseTableViewController

+ (void)pushWithReportId:(long long)reportId reportType:(ReportType)reportType fromVC:(UIViewController *)fromVC;

@end
