//
//  ViewController.m
//  iOSFrame模型解决多图文
//
//  Created by microleo on 16/7/24.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "ViewController.h"

#import "TopicDetailViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)detailClick:(id)sender {
    TopicDetailViewController *vc =[[TopicDetailViewController alloc]init];
    
    [self.navigationController popToViewController:vc animated:YES];
}

@end
