//
//  TopicDetailViewController.m
//  iOSFrame模型解决多图文
//
//  Created by microleo on 16/7/24.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "TopicDetailViewController.h"
#import "BabyScheduleTaskHeaderFrame.h"
#import "BabyScheduleTaskHeaderView.h"
#import "HedoneClassWeeklyTaskResponse.h"
@interface TopicDetailViewController ()

@property(nonatomic,strong) BabyScheduleTaskHeaderView *babyScheduleTaskHeaderView;

@property(nonatomic,strong) BabyScheduleTaskHeaderFrame *babyScheduleTaskHeaderFrame;

@end

@implementation TopicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor whiteColor];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
  HedoneAttachDTO *attach1 = [[HedoneAttachDTO alloc]init];
   attach1.addr = @"http://img.mp.itc.cn/upload/20160722/4e1168ef089345db863b0340282a6176_th.jpg";
   attach1.desp =@"这款跑车来自意大利飞雅特（菲亚特）的最新车型124 Spider，这款车号称美国当地最便宜的Turbo引擎敞篷车。由飞雅特与马自达共同合作开发，售价折合人民币15万元左右。";
    HedoneAttachDTO *attach2 = [[HedoneAttachDTO alloc]init];
    attach2.addr = @"http://img.mp.itc.cn/upload/20160722/d2546d440c4649a2bd3a5101f70d3a26_th.jpg";
    attach2.desp =@"它的底盘与马自达MX-5共用，车身则是飞雅特所开发，全车在日本广岛马自达工厂与MX-5并线生产同时它也是第一款由日本代工生产的意大利汽车，而且还是一款跑车。";
    HedoneAttachDTO *attach3 = [[HedoneAttachDTO alloc]init];
    attach3.addr = @"http://img.mp.itc.cn/upload/20160722/b0c7e04f750049999ae8ac373e20a087_th.jpg";
    attach3.desp =@"第一代124 Spider早在1966年推出，到1985年一共有20年的时间，是飞雅特在1960年到1980年代间敞篷小车的代表。如今飞雅特重新推出以该车命名的新车，还特别将过去车型的DNA刻意用在新车上，以带出世代传承的用意。";
    HedoneAttachDTO *attach4 = [[HedoneAttachDTO alloc]init];
    attach4.addr = @"http://img.mp.itc.cn/upload/20160722/c9090f5c8f6b42a59fe91988374c7296_th.jpg";
    attach4.desp =@"　动力方面，在美国当地配置的动力为一具2.0升Turbo引擎，飞雅特希望透过较强的动力规格和相近的售价，能够吸引年轻人能够投入飞雅特的怀抱。";
    
  
    NSMutableArray *attachs = [NSMutableArray array];
    [attachs addObject:attach1];
    [attachs addObject:attach2];
    [attachs addObject:attach3];
    [attachs addObject:attach4];
    
    HedoneClassWeeklyTaskResponse *hedoneClassWeeklyTaskResponse =[[HedoneClassWeeklyTaskResponse alloc]init];
    hedoneClassWeeklyTaskResponse.title =@"美国在售最便宜的跑车，超强动力，仅人民币15万元";
    hedoneClassWeeklyTaskResponse.content = @"这款跑车来自意大利飞雅特（菲亚特）的最新车型124 Spider，这款车号称美国当地最便宜的Turbo引擎敞篷车。由飞雅特与马自达共同合作开发，售价折合人民币15万元左右。";
    hedoneClassWeeklyTaskResponse.attachs = attachs;
    hedoneClassWeeklyTaskResponse.senderId = 12345;;
    hedoneClassWeeklyTaskResponse.senderName = @"microleo";
    hedoneClassWeeklyTaskResponse.senderPicture = @"http://blog.bomobox.org/images/avatar.png";
    //hedoneClassWeeklyTaskResponse.updateTime = ;
    
    [self configTableViewHeader:hedoneClassWeeklyTaskResponse];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- headerView
-(void) configTableViewHeader:(HedoneClassWeeklyTaskResponse *)model{
    BabyScheduleTaskHeaderFrame *detailHeaderFrame = [[BabyScheduleTaskHeaderFrame alloc]init];
    detailHeaderFrame.hedoneClassWeeklyTaskResponse = model;
    __unsafe_unretained typeof(self) selfVc = self;
    detailHeaderFrame.reloadNoticeHeaderFrameBlock = ^(){
        selfVc.babyScheduleTaskHeaderView.babyScheduleTaskHeaderFrame = selfVc.babyScheduleTaskHeaderFrame;
        CGRect oldHeaderF = selfVc.babyScheduleTaskHeaderView.frame;
        oldHeaderF.size.height = selfVc.babyScheduleTaskHeaderFrame.noticeHeaderHeight;
        selfVc.babyScheduleTaskHeaderView.frame = oldHeaderF;
        selfVc.tableView.tableHeaderView = selfVc.babyScheduleTaskHeaderView;
        
    };
    self.babyScheduleTaskHeaderFrame = detailHeaderFrame;
    
    BabyScheduleTaskHeaderView *detailHeaderView = [[BabyScheduleTaskHeaderView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, detailHeaderFrame.noticeHeaderHeight) andMomentPicturesCount:(int)model.attachs.count];
    detailHeaderView.babyScheduleTaskHeaderFrame = detailHeaderFrame;
   
    
    self.babyScheduleTaskHeaderView = detailHeaderView;
    
    self.tableView.tableHeaderView = self.babyScheduleTaskHeaderView;
    
}


//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
