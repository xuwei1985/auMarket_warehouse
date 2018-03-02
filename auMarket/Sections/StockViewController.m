//
//  StockViewController.m
//  auMarket
//
//  Created by 吴绪伟 on 2018/1/10.
//  Copyright © 2018年 daao. All rights reserved.
//

#import "StockViewController.h"

@interface StockViewController ()

@end

@implementation StockViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initData];
    [self addNotification];
}

-(void)initData{
    NSDictionary *dic1,*dic2,*dic3,*dic4,*dic5,*dic6,*dic7,*dic8,*dic9;
    itemArr=[[NSMutableArray alloc] init];
    
    dic1=[[NSDictionary alloc] initWithObjectsAndKeys:@"待结算现金",@"item_name", nil];
    dic2=[[NSDictionary alloc] initWithObjectsAndKeys:@"待结算转账",@"item_name", nil];
    dic3=[[NSDictionary alloc] initWithObjectsAndKeys:@"是否开启接单",@"item_name", nil];
    [itemArr addObject:[NSArray arrayWithObjects:dic1,dic2, nil]];
}


-(void)initUI{
    [self setNavigation];
    [self setUpTableView];
}

-(void)setNavigation{
    self.title=@"";
}

-(void)addNotification{
    
}

-(void)loadGoodsInfoByCode{
    [self.model loadBatchs];
}

-(void)onResponse:(SPBaseModel *)model isSuccess:(BOOL)isSuccess{
    [self stopLoadingActivityIndicator];
    
    if(model==self.model&&model.requestTag==1001){//获取列表
        if(isSuccess){
            
        }
        else{
            
        }
    }
}

-(void)setUpTableView{
    self.tableView=[[SPBaseTableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN-64) style:UITableViewStylePlain];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor=COLOR_BG_TABLESEPARATE;
    self.tableView.backgroundColor=COLOR_BG_TABLEVIEW;
    
    UIView *view = [UIView new];
    view.backgroundColor = COLOR_CLEAR;
    [self.tableView setTableHeaderView:_userInfoView];
    
    Boolean isLogin=[[AccountManager sharedInstance] isLogin];
    UIView *exitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 108)];
    exitView.backgroundColor = COLOR_CLEAR;
    
    _btn_exit=[UIButton buttonWithType:UIButtonTypeCustom];
    [_btn_exit setTitle:@"退出登录" forState:UIControlStateNormal];
    [_btn_exit setBackgroundColor:COLOR_MAIN];
    [_btn_exit setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
    _btn_exit.frame=CGRectMake(15, IPHONE6PLUS?60:64, WIDTH_SCREEN-30, 40);
    _btn_exit.titleLabel.font=FONT_SIZE_MIDDLE;
    [_btn_exit addTarget:self action:@selector(exitLogin:) forControlEvents:UIControlEventTouchUpInside];
    [_btn_exit.layer setCornerRadius:4];
    _btn_exit.hidden=isLogin;
    [exitView addSubview:_btn_exit];
    [self.tableView setTableFooterView:exitView];
    
    [self.view addSubview:self.tableView];
}


//注销
-(void)exitLogin:(id)sender{
    [[AlertBlockView sharedInstance] showChoiceAlert:@"您确定要退出登录吗？" button1Title:@"确认" button2Title:@"取消" completion:^(int index) {
        if(index==0){
            [[AccountManager sharedInstance] unRegisterLoginUser];
            [SVProgressHUD showSuccessWithStatus:@"您已成功退出登录。"];
            _btn_exit.hidden=YES;
            [self onUserNotLogin];
        }
    }];
}

#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _itemArr.count;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section
{
    return [[_itemArr objectAtIndex:section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==_itemArr.count-1){
        return 20;
    }
    return 0;
}

//设置每行每列的值
- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier=@"MemberCellIdentifier";
    MemberCell *cell = [tv dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MemberCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.showsReorderControl = NO;
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.backgroundColor=COLOR_BG_TABLEVIEWCELL;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.font=DEFAULT_FONT(16.0);
        cell.textLabel.textColor=COLOR_DARKGRAY;
    }
    
    cell.itemName =[[[_itemArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"item_name"];
    
    if(indexPath.section==1&&indexPath.row==[[_itemArr objectAtIndex:indexPath.section] count]-1){
        cell.itemPrice=@"";
    }
    else{
        if(indexPath.row==0){
            cell.itemPrice=[NSString stringWithFormat:@"$%.2f",[self.model.charge_entity.cash_charge floatValue]];
        }
        else if(indexPath.row==1){
            cell.itemPrice=[NSString stringWithFormat:@"$%.2f",[self.model.charge_entity.transfer_charge floatValue]];;
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tv deselectRowAtIndexPath:[tv indexPathForSelectedRow] animated:NO];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    [tableView setLayoutMargins:UIEdgeInsetsZero];
}


-(StockModel *)model{
    if(!_model){
        _model=[[StockModel alloc] init];
        _model.delegate=self;
    }
    return _model;
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
