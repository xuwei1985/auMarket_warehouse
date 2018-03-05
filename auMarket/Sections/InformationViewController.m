//
//  InformationViewController.m
//  auMarket
//
//  Created by 吴绪伟 on 2018/1/4.
//  Copyright © 2018年 daao. All rights reserved.
//

#import "InformationViewController.h"

@interface InformationViewController ()

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
    [self addNotification];
}

-(void)initData{
    
}

-(void)initUI{
    [self setNavigation];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 100, 28);
    btn.center=self.view.center;
    [btn setTitle:@"扫描条形码" forState:UIControlStateNormal];
    btn.titleLabel.font=DEFAULT_FONT(14);
    [btn setBackgroundColor: COLOR_BTN_GRAY];
    [btn addTarget:self action:@selector(startQRController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)startQRController{
    QRCodeViewController *vc = [[QRCodeViewController alloc] init];
    vc.title = @"二维码扫描";
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)setNavigation{
    self.title=@"信息";
}

-(void)addNotification{
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTaskUpdate:) name:TASK_UPDATE_NOTIFICATION object:nil];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
