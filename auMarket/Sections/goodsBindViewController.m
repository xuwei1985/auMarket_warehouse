//
//  goodsBindViewController.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/8.
//  Copyright © 2016年 daao. All rights reserved.
//
#define GOODS_SUM_BAR 44.0
#define DONE_ACTION_BAR 48.0
#import "goodsBindViewController.h"

@interface goodsBindViewController ()

@end

@implementation goodsBindViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    [self initData];
}

-(void)initUI{
    [self setNavigation];
    [self createSumView];
    [self setUpTableView];
    [self createDoneActionBar];
}

-(void)initData{
    [self loadGoodsForOrder];
    [self loadDeliveryInfo];
}

-(void)setNavigation{
    self.title=@"商品录入";
}

-(void)createSumView{
    UIView *blockView=[[UIView alloc] initWithFrame:CGRectMake(0, 12, WIDTH_SCREEN, GOODS_SUM_BAR)];
    blockView.backgroundColor=COLOR_WHITE;
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, blockView.frame.size.height-0.5, blockView.frame.size.width, 0.5);
    layer.backgroundColor = COLOR_BG_LINE_DARK.CGColor;
    [blockView.layer addSublayer:layer];
    
    
    UILabel *lbl_tip_1=[[UILabel alloc] init];
    lbl_tip_1.textColor=COLOR_BLACK;
    lbl_tip_1.font=FONT_SIZE_BIG;
    lbl_tip_1.text=@"当前录入总额";
    lbl_tip_1.textAlignment=NSTextAlignmentLeft;
    [blockView addSubview:lbl_tip_1];
    
    [lbl_tip_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(blockView.top).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
        make.left.mas_equalTo(10);
    }];
    
    lbl_goodsNum=[[UILabel alloc] init];
    lbl_goodsNum.textColor=COLOR_GRAY;
    lbl_goodsNum.font=FONT_SIZE_MIDDLE;
    lbl_goodsNum.text=@"";
    lbl_goodsNum.textAlignment=NSTextAlignmentLeft;
    [blockView addSubview:lbl_goodsNum];
    
    [lbl_goodsNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(blockView.top).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
        make.left.mas_equalTo(lbl_tip_1.mas_right).offset(5);
    }];
    
    lbl_sumPrice=[[UILabel alloc] init];
    lbl_sumPrice.textColor=COLOR_MAIN;
    lbl_sumPrice.font=FONT_SIZE_BIG_BLOD;
    lbl_sumPrice.text=@"$1234.12";
    lbl_sumPrice.textAlignment=NSTextAlignmentRight;
    [blockView addSubview:lbl_sumPrice];
    
    [lbl_sumPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(blockView.top).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
        make.right.mas_equalTo(blockView.mas_right).offset(-10);
    }];
}

-(void)setUpTableView{
    float table_height=HEIGHT_SCREEN-64-GOODS_SUM_BAR-10-DONE_ACTION_BAR;
    self.tableView=[[SPBaseTableView alloc] initWithFrame:CGRectMake(0, GOODS_SUM_BAR+10, WIDTH_SCREEN,table_height) style:UITableViewStylePlain];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor=COLOR_BG_TABLESEPARATE;
    self.tableView.backgroundColor=COLOR_BG_TABLEVIEW;
    
    UIView *view = [UIView new];
    view.backgroundColor = COLOR_CLEAR;
    
    [self.tableView setTableHeaderView:view];
    [self.tableView setTableFooterView:view];
    [self.view addSubview:self.tableView];
}

/**
 创建完成操作条
 */
-(void)createDoneActionBar{
   
    _btn_doneAction=[UIButton buttonWithType:UIButtonTypeCustom];
    [_btn_doneAction setTitle:@"+添加新商品" forState:UIControlStateNormal];
    _btn_doneAction.titleLabel.textAlignment=NSTextAlignmentCenter;
    [_btn_doneAction setBackgroundColor:COLOR_MAIN];
    _btn_doneAction.tintColor=COLOR_WHITE;
    _btn_doneAction.titleLabel.font=FONT_SIZE_BIG;
    [_btn_doneAction addTarget:self action:@selector(deliveryFinish) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn_doneAction];
    
    
    @weakify(self);
    [_btn_doneAction mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.mas_equalTo(self.view.mas_bottom).offset(-DONE_ACTION_BAR);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(WIDTH_SCREEN);
        make.height.mas_equalTo(DONE_ACTION_BAR);
    }];
    
}

//请求订单下的商品信息
-(void)loadGoodsForOrder{
//    [self startLoadingActivityIndicator];
//    [self.model loadGoodsListForOrder:self.task_entity.order_id];
}



-(void)onResponse:(SPBaseModel *)model isSuccess:(BOOL)isSuccess{
    [self stopLoadingActivityIndicator];
//    if(model==self.model&&self.model.requestTag==3002){
//        if(isSuccess){
//            [self.tableView reloadData];
//        }
//    }
}


#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier=@"BindCellIdentifier";
    GoodsBindCell *cell = [tv dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[GoodsBindCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.showsReorderControl = NO;
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.backgroundColor=COLOR_BG_TABLEVIEWCELL;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.font=FONT_SIZE_MIDDLE;
        cell.textLabel.textColor=COLOR_DARKGRAY;
    }
    if(indexPath.section==0){
        cell.itemName=[self.model.goods_entity.goods_list_normal objectAtIndex:indexPath.row].goods_name;
        cell.itemNum=[self.model.goods_entity.goods_list_normal objectAtIndex:indexPath.row].goods_number;
        cell.itemImage=[self.model.goods_entity.goods_list_normal objectAtIndex:indexPath.row].thumb_url;
    }
    else if(indexPath.section==1){
        cell.itemName=[self.model.goods_entity.goods_list_alone objectAtIndex:indexPath.row].goods_name;
        cell.itemNum=[self.model.goods_entity.goods_list_alone objectAtIndex:indexPath.row].goods_number;
        cell.itemImage=[self.model.goods_entity.goods_list_alone objectAtIndex:indexPath.row].thumb_url;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tv deselectRowAtIndexPath:[tv indexPathForSelectedRow] animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UITableView *tableview = (UITableView *)scrollView;
    CGFloat sectionHeaderHeight = 40;
    CGFloat sectionFooterHeight = 0;
    
    
    CGFloat offsetY = tableview.contentOffset.y;
    NSLog(@"offsetY:%f",offsetY);
    
    if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
    {
        tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= sectionHeaderHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight)
    {
        tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height)
    {
        if(offsetY>0){
            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight), 0);
        }
    }
    
}

-(void)deliveryFinish{
    if([self.task_entity.pay_type intValue]==4){//如果是货到付款，则须先选择结算方式
        [self showFinishMenu];
    }
    else{//如果是线上支付，直接调用配送完成接口
        [[AlertBlockView sharedInstance] showChoiceAlert:@"确认完成订单配送吗？" button1Title:@"确定" button2Title:@"取消" completion:^(int index) {
            if(index==0){
                [self setDeliveryDone:@"1" andPayType:@"0"];//0代表线上支付 1现金 2转账
            }
        }];
    }
}

- (void)showFinishMenu
{
    UIActionSheet *actionsheet;
    actionsheet = [[UIActionSheet alloc] initWithTitle:@"选择操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"现金结算", @"转账结算",@"无法配送", nil,nil];
    
    [actionsheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (0 == buttonIndex)//现金结算
    {
        [[AlertBlockView sharedInstance] showChoiceAlert:@"确认完成订单配送吗？" button1Title:@"确定" button2Title:@"取消" completion:^(int index) {
            if(index==0){
                [self setDeliveryDone:@"1" andPayType:@"1"];//0代表线上支付 1现金 2转账
            }
        }];
    }
    else if (1 == buttonIndex)//转账结算
    {
        if(lbl_orderNo.text.length>0){
            PaymentViewController *pvc=[[PaymentViewController alloc] init];
            pvc.task_entity=self.task_entity;
            pvc.order_sn=lbl_orderNo.text;
            [self.navigationController pushViewController:pvc animated:YES];
        }
        else{
            [self showToastTopWithText:@"没有配送订单信息"];
        }
        
    }
    else if (2 == buttonIndex)//无法配送
    {
        [self setDeliveryDone:@"2" andPayType:@"-1"];//0代表线上支付 1现金 2转账 -1未配送结算
    }
}

-(void)runNavigationByGoogle{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]){
        NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%@,%@&directionsmode=driving",APP_NAME,APP_SCHEME,self.task_entity.latitude, self.task_entity.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
    else{
        [self showToastBottomWithText:@"您未安装Google Maps"];
    }
}

-(void)makeCall:(UIGestureRecognizer *)sender{
    UILabel *lbl_sender=(UILabel *)sender.view;
    if(lbl_sender){
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",lbl_sender.text];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

-(TaskModel *)model{
    if(!_model){
        _model=[[TaskModel alloc] init];
        _model.delegate=self;
    }
    return _model;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
