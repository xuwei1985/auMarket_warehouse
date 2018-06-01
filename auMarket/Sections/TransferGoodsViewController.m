//
//  goodsBindViewController.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/8.
//  Copyright © 2016年 daao. All rights reserved.
//
#define CATEGORY_BAR 44.0
#import "TransferGoodsViewController.h"

@interface TransferGoodsViewController ()

@end

@implementation TransferGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    [self initData];
}

-(void)initUI{
    [self setNavigation];
    [self createCategoryView];
    [self setUpTableView];
    [self createBottomView];
}

-(void)initData{
    [self loadTransferGoodsList];
}

-(void)setNavigation{
    self.title=@"商品转移";
}

-(void)createCategoryView{
    blockView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, CATEGORY_BAR)];
    blockView.backgroundColor=COLOR_BG_WHITE;
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, blockView.frame.size.height-0.5, blockView.frame.size.width, 0.5);
    layer.backgroundColor = COLOR_BG_LINE_DARK.CGColor;
    [blockView.layer addSublayer:layer];
    [self.view addSubview:blockView];
    
    btn_picking=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn_picking setTitle:@"待转移" forState:UIControlStateNormal];
    [btn_picking setTitleColor:COLOR_DARKGRAY forState:UIControlStateNormal];
    [btn_picking setTitleColor:COLOR_MAIN forState:UIControlStateSelected];
    btn_picking.titleLabel.textAlignment=NSTextAlignmentCenter;
    btn_picking.tintColor=COLOR_WHITE;
    btn_picking.titleLabel.font=FONT_SIZE_SMALL;
    btn_picking.tag=7000;
    [btn_picking addTarget:self action:@selector(changePickState:) forControlEvents:UIControlEventTouchUpInside];
    [blockView addSubview:btn_picking];
    
    [btn_picking mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(WIDTH_SCREEN/2);
        make.height.mas_equalTo(blockView.mas_height);
    }];
    
    btn_picked=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn_picked setTitle:@"转移完成" forState:UIControlStateNormal];
    [btn_picked setTitleColor:COLOR_DARKGRAY forState:UIControlStateNormal];
    [btn_picked setTitleColor:COLOR_MAIN forState:UIControlStateSelected];
    btn_picked.titleLabel.textAlignment=NSTextAlignmentCenter;
    btn_picked.tintColor=COLOR_WHITE;
    btn_picked.titleLabel.font=FONT_SIZE_SMALL;
    btn_picked.tag=7001;
    [btn_picked addTarget:self action:@selector(changePickState:) forControlEvents:UIControlEventTouchUpInside];
    [blockView addSubview:btn_picked];

    [btn_picked mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(WIDTH_SCREEN/2);
        make.width.mas_equalTo(WIDTH_SCREEN/2);
        make.height.mas_equalTo(blockView.mas_height);
    }];
    
    if(self.list_type==0){
        btn_picking.selected=YES;
    }
    else{
        btn_picked.selected=YES;
    }
}

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
    _sumBtn.frame=CGRectMake(WIDTH_SCREEN-100, 0,100, 44);
    [_sumBtn setTitle:@"转移" forState:UIControlStateNormal];
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


-(void)changePickState:(UIButton *)sender{
    int btn_index=(int)sender.tag-7000;
    if(self.list_type!=btn_index)
    {
        if(!self.model.isLoading){
            self.list_type=btn_index;
            ((UIButton *)[blockView viewWithTag:7000]).selected=NO;
            ((UIButton *)[blockView viewWithTag:7001]).selected=NO;
            sender.selected=YES;
            
            [self loadTransferGoodsList];
        }
    }
}

-(void)setUpTableView{
    float table_height=HEIGHT_SCREEN-64-CATEGORY_BAR-44;
    self.tableView=[[SPBaseTableView alloc] initWithFrame:CGRectMake(0, CATEGORY_BAR, WIDTH_SCREEN,table_height) style:UITableViewStylePlain];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor=COLOR_BG_TABLESEPARATE;
    self.tableView.backgroundColor=COLOR_BG_TABLEVIEW;
    
    UIView *view = [UIView new];
    view.backgroundColor = COLOR_CLEAR;
    
    [self.tableView setTableHeaderView:view];
    [self.tableView setTableFooterView:view];
    [self.view addSubview:self.tableView];
}



//请求需要转移的商品
-(void)loadTransferGoodsList{
    [self startLoadingActivityIndicator];
    [self.model loadGoodsListWithListType:self.list_type];
}

-(void)finishGoodsPick:(PickGoodsEntity *)entity{
    [self startLoadingActivityIndicator];
    [self.model finishGoodsPick:entity.rec_id andOrderId:entity.order_id];
}

-(void)onResponse:(SPBaseModel *)model isSuccess:(BOOL)isSuccess{
    [self stopLoadingActivityIndicator];
    
    if(model==self.model&&self.model.requestTag==1002){
        if(isSuccess){
            [self.tableView reloadData];
            if(self.model.pickGoodsListEntity.list&&self.model.pickGoodsListEntity.list.count>0){
                [self hideNoContentView];
            }
            else{
                [self showNoContentView];
            }
        }
        else{
            [self showFailWithText:@"获取商品失败"];
        }
    }
    else if(model==self.model&&self.model.requestTag==1005){
        if(isSuccess){
            [self doCellDelete];
            if([self.model.pickGoodsListEntity.list count]<=0){
                [self showSuccesWithText:@"拣货完成"];
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    [self goBack];
                });
            }
        }
        else{
            [self showFailWithText:@"拣货确认提交失败"];
        }
    }
}


#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section
{
    return self.model.pickGoodsListEntity.list.count;
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
    TransferGoodsCell *cell = [tv dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[TransferGoodsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.showsReorderControl = NO;
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.backgroundColor=COLOR_BG_TABLEVIEWCELL;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.font=FONT_SIZE_MIDDLE;
        cell.textLabel.textColor=COLOR_DARKGRAY;
    }
    
    PickGoodsEntity *entity=[self.model.pickGoodsListEntity.list objectAtIndex:indexPath.row];
    cell.entity=entity;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 122;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tv deselectRowAtIndexPath:[tv indexPathForSelectedRow] animated:NO];
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"扫描货架" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        PickGoodsEntity *entity=[self.model.pickGoodsListEntity.list objectAtIndex:indexPath.row];
        current_confirm_path=indexPath;
        if(entity&&[entity.order_id length]>0){
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

-(void)passObject:(id)obj{
    if([[obj objectForKey:@"scan_model"] intValue]==SCAN_SHELF){//货架条形码
        //提交绑定信息到接口
        if([[obj objectForKey:@"code"] length]>0){
            //绑定货架信息到商品数据
            [self.tableView reloadData];
            [self showSuccesWithText:@"货架扫描成功"];
        }
        else{
            [self showToastWithText:@"扫码结果无效"];
        }
    }
    else{
        [self showToastWithText:@"未知扫码结果"];
    }
}


-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)gotoScanQRView{
    QRCodeViewController *qvc=[[QRCodeViewController alloc] init];
    qvc.scan_model=SCAN_SHELF;
    qvc.pass_delegate=self;
    [self.navigationController pushViewController:qvc animated:YES];
}

-(void)doCellDelete{
    [self.model.pickGoodsListEntity.list removeObjectAtIndex:current_confirm_path.row];
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[current_confirm_path] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

-(PickModel *)model{
    if(!_model){
        _model=[[PickModel alloc] init];
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
