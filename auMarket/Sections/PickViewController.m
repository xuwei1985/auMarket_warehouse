//
//  PickViewController.m
//  auMarket
//
//  Created by 吴绪伟 on 2018/1/4.
//  Copyright © 2018年 daao. All rights reserved.
//

#import "PickViewController.h"

@interface PickViewController ()

@end

@implementation PickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initData];
}

-(void)initData{
    [self loadOrders];
}

-(void)initUI{
    [self setNavigation];
    [self setUpRegionsView];
    [self setUpTableView];
    [self createBottomView];
}

-(void)setNavigation{
//    self.title=@"拣货";
    
    btn_region = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_region.frame= CGRectMake(0, 0, 100, 29);
    [btn_region setBackgroundImage:[UIImage imageNamed:@"1_04"] forState:UIControlStateNormal];
    [btn_region setBackgroundImage:[UIImage imageNamed:@"1_03"] forState:UIControlStateSelected];
    [btn_region setTitle:@"全部区域" forState:UIControlStateNormal];
    btn_region.titleLabel.font=FONT_SIZE_MIDDLE;
    [btn_region setTitleColor:COLOR_BLACK forState:UIControlStateNormal];
    [btn_region addTarget:self action:@selector(showRegionsView) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView=btn_region;
    
    UIBarButtonItem *left_Item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"hs"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(gotoPickedGoodsView)];
    self.navigationItem.leftBarButtonItem=left_Item;
    
    UIBarButtonItem *right_Item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"jhz"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(gotoPickingGoodsView)];
    self.navigationItem.rightBarButtonItem=right_Item;
}

//-(void)addNotification{
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadOrders) name:TASK_ORDER_NOTIFICATION object:nil];
//}
//
//- (void)removeNotification{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TASK_ORDER_NOTIFICATION" object:nil];
//}

-(void)createBottomView{
    _summaryView_bottom=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 44)];
    _summaryView_bottom.backgroundColor=COLOR_BG_WHITE;
    [self.view addSubview:_summaryView_bottom];
    
    [_summaryView_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_bottom).offset(-44);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(WIDTH_SCREEN);
        make.height.mas_equalTo(44);
    }];

    UIView *_baseLineView=[[UIView alloc] init];
    _baseLineView.backgroundColor=COLOR_BG_TABLESEPARATE;
    [_summaryView_bottom addSubview:_baseLineView];
    
    [_baseLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_summaryView_bottom.mas_top);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(WIDTH_SCREEN);
        make.height.mas_equalTo(0.5);
    }];
    
    _sumBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _sumBtn.frame=CGRectMake(WIDTH_SCREEN-110, 0,110, 44);
    [_sumBtn setTitle:@"生成清单" forState:UIControlStateNormal];
    _sumBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    _sumBtn.backgroundColor=COLOR_MAIN;
    _sumBtn.titleLabel.font=FONT_SIZE_MIDDLE;
    [_sumBtn setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
    [_sumBtn addTarget:self action:@selector(gotoPickList) forControlEvents:UIControlEventTouchUpInside];
    [_summaryView_bottom addSubview:_sumBtn];
    
   
    _selectAllBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _selectAllBtn.frame=CGRectMake(10, 0,72, 44);
    [_selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    _selectAllBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    _selectAllBtn.backgroundColor=COLOR_CLEAR;
    _selectAllBtn.titleLabel.font=FONT_SIZE_MIDDLE;
    [_selectAllBtn setTitleColor:COLOR_BLACK forState:UIControlStateNormal];
    [_selectAllBtn setImage:[UIImage imageNamed:@"AliRefundKit_select_normal"] forState:UIControlStateNormal];
    [_selectAllBtn setImage:[UIImage imageNamed:@"AliRefundKit_select_checked"] forState:UIControlStateSelected];
    [_selectAllBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -15, 0.0, 0.0)];
    [_selectAllBtn addTarget:self action:@selector(selectAllOrders:) forControlEvents:UIControlEventTouchUpInside];
    [_summaryView_bottom addSubview:_selectAllBtn];
}

-(void)setUpTableView{
    float table_height=HEIGHT_SCREEN-64-48-44;
    self.tableView=[[SPBaseTableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN,table_height) style:UITableViewStylePlain];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor=COLOR_BG_TABLESEPARATE;
    self.tableView.backgroundColor=COLOR_BG_TABLEVIEW;
    
    UIView *view = [UIView new];
    view.backgroundColor = COLOR_CLEAR;
    
    [self.tableView setTableFooterView:view];
    [self.view insertSubview:self.tableView belowSubview:regionsView];
    
     MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadOrders)];
    
//    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing]; // 松手刷新
    header.stateLabel.font = FONT_SIZE_SMALL;
    header.stateLabel.textColor = COLOR_DARKGRAY;
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden=YES;
//    [header beginRefreshing];
    
    self.tableView.mj_header=header;
}

-(void)setUpRegionsView{
    regionsView=[[SPBaseTableView alloc] initWithFrame:CGRectMake(WIDTH_SCREEN*0.2, 10, WIDTH_SCREEN*0.6,WIDTH_SCREEN*0.6*1.4) style:UITableViewStylePlain];
    regionsView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    regionsView.separatorColor=COLOR_BG_TABLESEPARATE;
    regionsView.backgroundColor=COLOR_BG_WHITE;
    regionsView.layer.borderColor=COLOR_LIGHTGRAY.CGColor;
    regionsView.layer.borderWidth=1;
    regionsView.layer.cornerRadius=8;
    regionsView.clipsToBounds=YES;
    regionsView.tag=1234;
    regionsView.delegate=self;
    regionsView.dataSource=self;
    regionsView.hidden=YES;
    
    UIView *view = [UIView new];
    view.backgroundColor = COLOR_CLEAR;
    [self.tableView setTableFooterView:view];
    [self.view addSubview:regionsView];
}

-(void)showRegionsView{
    [self showMaskView];
    regionsView.alpha=0;
    regionsView.hidden=NO;
    _summaryView_bottom.hidden=YES;
    float table_height=HEIGHT_SCREEN-64-48;
    self.tableView.frame=CGRectMake(0, 0, WIDTH_SCREEN,table_height);
    [UIView animateWithDuration:0.35 animations:^{
        regionsView.alpha=1;
    }];
}

-(void)hideRegionsView{
    [self hideMaskView];
    _summaryView_bottom.hidden=NO;
    float table_height=HEIGHT_SCREEN-64-48-44;
    self.tableView.frame=CGRectMake(0, 0, WIDTH_SCREEN,table_height);
    [UIView animateWithDuration:0.35 animations:^{
        regionsView.alpha=0;
    } completion:^(BOOL finished) {
        regionsView.hidden=YES;
    }];
}

-(void)selectAllOrders:(UIButton *)sender{
    int n=0;
    for(int i=0;i<self.model.entity.list.count;i++){
        if([self.model.entity.list objectAtIndex:i].box!=nil&&[[self.model.entity.list objectAtIndex:i].box length]>0){
            [self.model.entity.list objectAtIndex:i].selected=!sender.selected;
            n++;
        }
    }
    
    if(n>0){
        sender.selected=!sender.selected;
        if(n<[self.model.entity.list count]&&sender.selected){
            [self showToastWithText:@"有订单未绑定货箱"];
        }
    }
    
    if(sender.selected){
        [_sumBtn setTitle:[NSString stringWithFormat:@"生成清单(%d)",n] forState:UIControlStateNormal];
    }
    else{
         [_sumBtn setTitle:[NSString stringWithFormat:@"生成清单"] forState:UIControlStateNormal];
    }
    [self.tableView reloadData];
}

-(void)handlerOrdersSelect{
    int sel_num=0;
    for(int i=0;i<self.model.entity.list.count;i++){
        if([self.model.entity.list objectAtIndex:i].selected){
            sel_num++;
        }
    }
    
    if(sel_num==0){
        _selectAllBtn.selected=NO;
    }
    else if(sel_num==self.model.entity.list.count){
        _selectAllBtn.selected=YES;
    }
    
    if(sel_num>0){
        [_sumBtn setTitle:[NSString stringWithFormat:@"生成清单(%d)",sel_num] forState:UIControlStateNormal];
    }
    else{
        [_sumBtn setTitle:[NSString stringWithFormat:@"生成清单"] forState:UIControlStateNormal];
    }
    [self.tableView reloadData];
}

-(NSString *)getSelectedOrdersId{
    NSString *order_ids=@"";
    for(int i=0;i<self.model.entity.list.count;i++){
        if([self.model.entity.list objectAtIndex:i].selected){
            order_ids=[NSString stringWithFormat:@"%@%@,",order_ids,[self.model.entity.list objectAtIndex:i].order_id];
        }
    }
    if(order_ids.length>0){
        order_ids=[order_ids substringWithRange:NSMakeRange(0, order_ids.length-1)];
    }
    return order_ids;
}

#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section
{
    if(tv.tag==1234){
        return 10;
    }
    else{
        return self.model.entity.list.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tv.tag==1234){
        NSString *identifier=@"regionCellIdentifier";
        UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            cell.showsReorderControl = NO;
            cell.accessoryType=UITableViewCellAccessoryNone;
            cell.backgroundColor=COLOR_BG_TABLEVIEWCELL;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
           
        }
         cell.textLabel.font=FONT_SIZE_SMALL;
        if(indexPath.row%2==0){
            cell.textLabel.text=@"City区块";
        }
        else{
            cell.textLabel.text=@"St Kilda区块";
        }
        return cell;
    }
    else{
        NSString *identifier=@"pickCellIdentifier";
        PickOrderCell *cell = [tv dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[PickOrderCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            cell.showsReorderControl = NO;
            cell.accessoryType=UITableViewCellAccessoryNone;
            cell.backgroundColor=COLOR_BG_TABLEVIEWCELL;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        OrderItemEntity *entity=[self.model.entity.list objectAtIndex:indexPath.row];
        cell.entity=entity;
        [cell selOrderId:^(NSString *order_id,int action) {
            if(action>=0){
                [self handlerOrdersSelect];
            }
            else{
                [self showToastWithText:@"请先侧滑扫描货箱"];
            }
        }];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tv.tag==1234){
        return 38;
    }
    else{
        OrderItemEntity *entity=[self.model.entity.list objectAtIndex:indexPath.row];
        if([self hasSpecialPackage:entity]){
            return 175;
        }
        else{
            return 145;
        }
    }
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tv deselectRowAtIndexPath:[tv indexPathForSelectedRow] animated:NO];
    if(tv.tag==1234){
        
    }
    else{
        PickOrderCell *cell=[tv cellForRowAtIndexPath:indexPath];
        [cell toggleOrderSel];
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==1234){
        return YES;
    }
    else{
        return NO;
    }
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"扫描货箱" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        OrderItemEntity *entity=[self.model.entity.list objectAtIndex:indexPath.row];
        self.bind_order_entity=entity;
        if(self.bind_order_entity&&[self.bind_order_entity.order_id length]>0){
            [self gotoScanQRView];
        }
        else{
            [self showToastWithText:@"无效的订单信息"];
        }
    }];
    return @[deleteAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==1234){
        [cell setSeparatorInset:UIEdgeInsetsZero];
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(BOOL)hasSpecialPackage:(OrderItemEntity *)entity{
    if(entity){
        if([entity.attribute.frozen intValue]>0||[entity.attribute.cold intValue]>0||[entity.attribute.package intValue]>0){
            return YES;
        }
        else{
            return NO;
        }
    }
    return NO;
}

-(void)loadOrders{
    if(!self.tableView.mj_header.isRefreshing){
        [self startLoadingActivityIndicator];
    }
    
    [self.model loadOrdersWithListType:0];
}

-(void)bindBoxToOrder:(NSString *)order_id andBoxCode:(NSString *)box_code{
    [self startLoadingActivityIndicator];
    [self.model bindBoxToOrder:order_id andBoxCode:box_code];
}


-(void)beginOrders:(NSString *)order_ids{
    if(order_ids.length>0){
        [self startLoadingActivityIndicatorWithText:@"生成中"];
        [self.model beginOrders:order_ids];
    }
    else{
        [self showToastWithText:@"未选择任何订单"];
    }
}

-(void)onResponse:(SPBaseModel *)model isSuccess:(BOOL)isSuccess{
    [self stopLoadingActivityIndicator];
    
    if(model==self.model){
        if(model.requestTag==1001){
            [self.tableView.mj_header endRefreshing];
            if(self.model.entity.list!=nil){
                [self.tableView reloadData];
                if([self.model.entity.list count]<=0){
                    _selectAllBtn.selected=NO;
                    [_sumBtn setTitle:[NSString stringWithFormat:@"生成清单"] forState:UIControlStateNormal];
                    [self showNoContentView];
                }else{
                    [self hideNoContentView];
                }
            }
        }
        else if(model.requestTag==1003){
            if(isSuccess){
                //重新请求订单数据
                [self showSuccesWithText:@"货箱绑定成功"];
                self.model.entity.next=0;
                [self loadOrders];
            }
        }
        else if(model.requestTag==1004){
            if(isSuccess){
                PickGoodsViewController *pvc=[[PickGoodsViewController alloc] init];
                isPushToPickGoodsView=YES;
                [self.navigationController pushViewController:pvc animated:YES];
            }
        }
    }
}

-(void)passObject:(id)obj{
    if([[obj objectForKey:@"scan_model"] intValue]==SCAN_BOX){//货箱条形码
        //提交绑定信息到接口
        NSRange range = [[obj objectForKey:@"code"] rangeOfString:@"-"];
        if([[obj objectForKey:@"code"] length]>0&&range.location != NSNotFound){
            [self bindBoxToOrder:self.bind_order_entity.order_id andBoxCode:[obj objectForKey:@"code"]];
        }
        else{
            [self showToastWithText:@"无法识别的货箱条码"];
        }
    }
    else{
        [self showToastWithText:@"未知扫码结果"];
    }
}

-(void)gotoScanQRView{
    QRCodeViewController *qvc=[[QRCodeViewController alloc] init];
    qvc.scan_model=SCAN_BOX;
    qvc.pass_delegate=self;
    [self.navigationController pushViewController:qvc animated:YES];
}

-(void)gotoPickList{
    order_ids= [self getSelectedOrdersId];
    if(order_ids.length>0){
        [self beginOrders:order_ids];
    }
    else{
        [self showToastWithText:@"未选择任何订单"];
    }
}

-(void)gotoPickingGoodsView{
    PickGoodsViewController *pvc=[[PickGoodsViewController alloc] init];
    pvc.list_type=0;
    [self.navigationController pushViewController:pvc animated:YES];
}

-(void)gotoPickedGoodsView{
    PickedOrdersViewController *pvc=[[PickedOrdersViewController alloc] init];
    [self.navigationController pushViewController:pvc animated:YES];
}

-(PickModel *)model{
    if(!_model){
        _model=[[PickModel alloc] init];
        _model.delegate=self;
    }
    return _model;
}

-(void)viewWillAppear:(BOOL)animated{
    if(isPushToPickGoodsView){
        isPushToPickGoodsView=NO;
        [self loadOrders];
    }
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
