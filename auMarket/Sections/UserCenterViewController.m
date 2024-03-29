//
//  UserCenterViewController.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/8.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "UserCenterViewController.h"

@interface UserCenterViewController ()

@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotification];
    [self initUI];
    [self initData];
    [self onAccountUpdate:nil];
}

-(void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAccountUpdate:) name:ACCOUNT_UPDATE_NOTIFICATION object:nil];
}

-(void)initUI{
    [self setNavigation];
    [self createMemberInfoView];
    [self setUpTableView];
}

-(void)initData{
    NSDictionary *dic1,*dic2,*dic3,*dic4,*dic5;
    _itemArr=[[NSMutableArray alloc] init];
    
    dic1=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"库存转移",@"item_name",@"6",@"item_icon",@"0",@"item_value", nil];
    dic2=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"盘点库存",@"item_name",@"5",@"item_icon",@"1",@"item_value", nil];
    dic3=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"入库",@"item_name",@"8",@"item_icon",@"2",@"item_value", nil];
    dic4=[[NSDictionary alloc] initWithObjectsAndKeys:@"角色名称",@"item_name",@"7", @"item_icon",nil];
    dic5=[[NSDictionary alloc] initWithObjectsAndKeys:@"系统版本",@"item_name",@"icon_infomation", @"item_icon",nil];
    [_itemArr addObject:[NSArray arrayWithObjects:dic1,dic2,dic3,dic4,dic5, nil]];
}


-(void)setNavigation{
    self.title=@"我的";
}

-(void)createMemberInfoView{
    _userInfoView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, WIDTH_SCREEN*0.5)];
    _userInfoView.userInteractionEnabled=YES;
    _userInfoView.backgroundColor=COLOR_CLEAR;
    
    _headView=[[UIImageView alloc] init];
    _headView.image=[UIImage imageNamed:@"default_head.jpg"];
    _headView.clipsToBounds=YES;
    _headView.backgroundColor=COLOR_WHITE;
    [_headView.layer setCornerRadius:38];
    [_userInfoView addSubview:_headView];
    
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_userInfoView.mas_centerX);
        make.centerY.mas_equalTo(_userInfoView.mas_centerY).offset(-15);
        make.size.mas_equalTo(CGSizeMake(76, 76));
    }];
    
    
    _nicknameLbl=[[UILabel alloc] init];
    _nicknameLbl.textColor=COLOR_MAIN;
    _nicknameLbl.font=FONT_SIZE_BIG;
    _nicknameLbl.text=@"";
    _nicknameLbl.hidden=YES;
    _nicknameLbl.userInteractionEnabled=YES;
    _nicknameLbl.textAlignment=NSTextAlignmentCenter;
    [_userInfoView addSubview:_nicknameLbl];
    
    [_nicknameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 20));
        make.centerX.mas_equalTo(_userInfoView.mas_centerX);
    }];
    
    [_nicknameLbl addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoMemberLogin)]];
    
    _loginLbl=[[UILabel alloc] init];
    _loginLbl.textColor=COLOR_MAIN;
    _loginLbl.font=FONT_SIZE_BIG;
    _loginLbl.text=@"立即登录>>";
    _loginLbl.hidden=NO;
    _loginLbl.userInteractionEnabled=YES;
    _loginLbl.textAlignment=NSTextAlignmentCenter;
    [_userInfoView addSubview:_loginLbl];
    
    [_loginLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 20));
        make.centerX.mas_equalTo(_userInfoView.mas_centerX);
    }];
    
    [_loginLbl addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoMemberLogin)]];
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
    _btn_exit.frame=CGRectMake(15, IPHONE6PLUS?40:44, WIDTH_SCREEN-30, 46);
    _btn_exit.titleLabel.font=FONT_SIZE_MIDDLE;
    [_btn_exit addTarget:self action:@selector(exitLogin:) forControlEvents:UIControlEventTouchUpInside];
    [_btn_exit.layer setCornerRadius:23];
    _btn_exit.hidden=isLogin;
    [exitView addSubview:_btn_exit];
    [self.tableView setTableFooterView:exitView];
    
    [self.view addSubview:self.tableView];
}


-(void)onResponse:(SPBaseModel *)model isSuccess:(BOOL)isSuccess{
    if(model==self.model){
        if(isSuccess){
            [self.tableView reloadData];
        }
    }
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
    cell.iconImage=[UIImage imageNamed:[[[_itemArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"item_icon"]];
    cell.itemName =[[[_itemArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"item_name"];
    if(indexPath.row<3){
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.itemPrice=@"";
    }
    else if(indexPath.row==3){
        cell.accessoryType=UITableViewCellAccessoryNone;
        SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
        cell.itemPrice=user.role_name;
    }
    else if(indexPath.row==4){
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.itemPrice=SYSTEM_VERSION_STRING;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tv deselectRowAtIndexPath:[tv indexPathForSelectedRow] animated:NO];
    if(indexPath.row==0){
        [self gotoTransferView];
    }
    else if(indexPath.row==1){
        [self gotoInventoryCheckView];
    }
    else if(indexPath.row==2){
        [self gotoBatchView];
    }
}


-(void)gotoTransferView{
    TransferViewController *tvc=[[TransferViewController alloc] init];
    [self.navigationController pushViewController:tvc animated:YES];
}

-(void)gotoInventoryCheckView{
    InventoryCheckViewController *svc=[[InventoryCheckViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}

-(void)gotoBatchView{
    BatchViewController *batchViewController = [[BatchViewController alloc] init];
    batchViewController.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:batchViewController animated:YES];
}


- (void)onAccountUpdate:(NSNotification*)aNotitification{
    BOOL login = [aNotitification.object boolValue];
    if(aNotitification==nil){
        login=[[AccountManager sharedInstance] isLogin];
    }
    if (login) {
        _loginLbl.hidden=YES;
        _nicknameLbl.hidden=NO;

        SPAccount *_account = [AccountManager sharedInstance].getCurrentUser;
        _nicknameLbl.text=_account.user_nickname;
        [_headView sd_setImageWithURL:[NSURL URLWithString:_account.user_avatar] placeholderImage:[UIImage imageNamed:@"default_head.jpg"]];
        
    }
    else{
        _loginLbl.hidden=NO;
        _nicknameLbl.hidden=YES;
        _headView.image=[UIImage imageNamed:@"default_head.jpg"];
    }
    _btn_exit.hidden=!login;
}

-(void)gotoMyCartView{
    [[AppDelegate getTabbarController] setSelectedIndex:2];
}

-(void)gotoMemberLogin{
    [[AccountManager sharedInstance] showLoginWithModalState];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self checkLoginStatus];
}

-(MemberLoginModel *)model{
    if(!_model){
        _model=[[MemberLoginModel alloc] init];
        _model.delegate=self;
    }
    return _model;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
