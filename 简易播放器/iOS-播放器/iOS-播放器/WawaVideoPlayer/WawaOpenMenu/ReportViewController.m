//
//  ReportViewController.m
//  wwface
//
//  Created by pc on 16/6/24.
//  Copyright © 2016年 fo. All rights reserved.
//

#import "ReportViewController.h"
#import "ReportCell.h"
#import "PHTextView.h"
#import "ReportResource.h"
#import "HedoneComplainResourceImpl.h"

@interface ReportViewController ()
{
    ReportModel * currentModel;
}

@property (nonatomic, assign) long long reportId;
@property (nonatomic, assign) ReportType reportType;
@property (nonatomic, strong) NSMutableArray * dataSource;

@property (weak, nonatomic) IBOutlet PHTextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *subBtn;


@end

@implementation ReportViewController

static NSString * identifier = @"identifier_ReportCell";

+ (void)pushWithReportId:(long long)reportId reportType:(ReportType)reportType fromVC:(UIViewController *)fromVC
{
    UIStoryboard * touchSB = [UIStoryboard storyboardWithName:@"WawaTouchView" bundle:nil];
    ReportViewController * reportVC = [touchSB instantiateViewControllerWithIdentifier:@"ReportViewControllerSBID"];
    reportVC.reportId = reportId;
    reportVC.reportType = reportType;
    fromVC.hidesBottomBarWhenPushed = YES;
    [fromVC.navigationController pushViewController:reportVC animated:YES];
}

#pragma mark- viewCircle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    pageName = @"举报界面";
    self.title = @"举报";
    
    self.dataSource = [NSMutableArray array];
    
    [self configUI];
    [self loadData];
}

- (IBAction)submitBtnAction:(UIButton *)sender
{
    if (currentModel && currentModel.selected) {
        
        HedoneComplainRequest * request = [[HedoneComplainRequest alloc] init];
        request.reportType = [self getReportType];
        request.contentType = currentModel.value;
        request.dataId = self.reportId;
        request.desp = self.textView.text.length ? self.textView.text : @"";
        
        [HedoneComplainResourceImpl saveComplainWithComplainRequest:request loadingView:self.view completion:^(bool succeed, NSString *ret) {
            if (succeed) {
                [self.navigationController popViewControllerAnimated:YES];
                [MBProgressHUD showMessage:@"举报成功" toView:nil];
            }
        }];
    } else {
        [MBProgressHUD showMessage:@"请选择举报内容" toView:self.view];
    }
}

- (int)getReportType
{
    int type = 0;
    if (self.reportType == ReportType_BabyShow) {
        type = 3;
    } else if (self.reportType == ReportType_BabyShowReply) {
        type = 1;
    } else if (self.reportType == ReportType_Topic) {
        type = 4;
    } else if (self.reportType == ReportType_TopicReply) {
        type = 2;
    } else if (self.reportType == ReportType_TeacherConsulting) {
        type = 2;
    }
    return type;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)configUI
{
    [self.tableView registerClass:[ReportCell class] forCellReuseIdentifier:identifier];
    self.textView.placeholder = @"请输入举报原因(选填)";
    self.textView.layer.cornerRadius = 3;
    self.textView.layer.masksToBounds = YES;
    self.subBtn.layer.cornerRadius = 3;
    self.subBtn.layer.masksToBounds = YES;
}

#pragma mark- LoadData
- (void)loadData
{
    [HedoneComplainResourceImpl getComplainContentTypesloadingView:self.view completion:^(bool succeed, NSArray *ret) {
        if (succeed) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                for (HedoneReportContentTypeDTO * dto in ret) {
                    ReportModel * model = [[ReportModel alloc] init];
                    model.name = dto.name;
                    model.value = dto.value;
                    model.selected = NO;
                    [self.dataSource addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            });
        }
    }];
}

#pragma mark- UITableViewDelegate UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReportCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell configCellWithModel:self.dataSource.count > indexPath.row ? self.dataSource[indexPath.row] : nil];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ReportModel * model = self.dataSource.count > indexPath.row ? self.dataSource[indexPath.row] : nil;
        for (ReportModel * dto in self.dataSource) {
            if ([dto.name isEqualToString:model.name]) {
                dto.selected = YES;
                currentModel = dto;
            } else {
                dto.selected = NO;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}



@end
