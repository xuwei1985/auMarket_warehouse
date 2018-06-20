//
//  goodsBindViewController.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/8.
//  Copyright © 2016年 daao. All rights reserved.
//
#define CATEGORY_BAR 44.0
#import "PickGoodsViewController.h"

@interface PickGoodsViewController ()

@end

@implementation PickGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    [self initData];
}

-(void)initUI{
    [self setNavigation];
    [self createCategoryView];
    [self setUpTableView];
}

-(void)initData{
    [self loadPickGoodsList];
}

-(void)setNavigation{
    self.title=@"拣货";
    
    UIButton *doneBtn=[[UIButton alloc] initWithFrame:CGRectMake(WIDTH_SCREEN-40, 4, 40, 32)];
    [doneBtn addTarget:self action:@selector(finishPicking) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setTitle:@"完成拣货" forState:UIControlStateNormal];
    [doneBtn setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
    [doneBtn setTitleColor:COLOR_WHITE forState:UIControlStateHighlighted];
    doneBtn.titleLabel.font=FONT_SIZE_MIDDLE;
    doneBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    
    UIBarButtonItem *right_Item_cart = [[UIBarButtonItem alloc] initWithCustomView:doneBtn];
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.navigationItem.rightBarButtonItem=right_Item_cart;
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
    [btn_picking setTitle:@"正在拣货" forState:UIControlStateNormal];
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
    [btn_picked setTitle:@"拣货完成" forState:UIControlStateNormal];
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

-(void)changePickState:(UIButton *)sender{
    int btn_index=(int)sender.tag-7000;
    if(self.list_type!=btn_index)
    {
        if(!self.model.isLoading){
            self.list_type=btn_index;
            ((UIButton *)[blockView viewWithTag:7000]).selected=NO;
            ((UIButton *)[blockView viewWithTag:7001]).selected=NO;
            sender.selected=YES;
            
            [self loadPickGoodsList];
        }
    }
}

-(void)setUpTableView{
    float table_height=HEIGHT_SCREEN-64-CATEGORY_BAR;
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



//请求订单下的要拣货的商品
-(void)loadPickGoodsList{
    [self startLoadingActivityIndicator];
    [self.model loadGoodsListWithListType:self.list_type];
}

-(void)finishGoodsPick:(PickGoodsEntity *)entity{
    [self startLoadingActivityIndicator];
    [self.model finishGoodsPick:entity.rec_id andOrderId:entity.order_id];
}

-(void)finishPicking{
    [self startLoadingActivityIndicator];
//    [self.model finishGoodsPick:entity.rec_id andOrderId:entity.order_id];
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
    PickGoodsCell *cell = [tv dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[PickGoodsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
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
    return 132;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tv deselectRowAtIndexPath:[tv indexPathForSelectedRow] animated:NO];
    
    if(self.list_type==0){
        PickGoodsEntity *entity=[self.model.pickGoodsListEntity.list objectAtIndex:indexPath.row];
        current_confirm_path=indexPath;
        
        GoodsEntity *goods_entity=[[GoodsEntity alloc] init];
        goods_entity.goods_id=entity.goods_id;
        goods_entity.goods_code=entity.goods_code;
        goods_entity.goods_name=entity.goods_name;
        goods_entity.goods_thumb=entity.goods_thumb;
        goods_entity.shop_price=entity.goods_price;
        goods_entity.shelves_no=entity.shelves_code;
        [self showActionSheet:goods_entity];
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.list_type==0){
        return YES;
    }
    else{
        return NO;
    }
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"确认拣货" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        PickGoodsEntity *entity=[self.model.pickGoodsListEntity.list objectAtIndex:indexPath.row];
        current_confirm_path=indexPath;
        [self finishGoodsPick:entity];
        
    }];

    return @[deleteAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
}

- (void)showActionSheet:(GoodsEntity *)entity {
    //显示弹出框列表选择
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"选择操作"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             
                                                         }];
    UIAlertAction* transferAction = [UIAlertAction actionWithTitle:@"转移库存" style:UIAlertActionStyleDestructive
                                                       handler:^(UIAlertAction * action) {
                                                           [self gotoGoodsShelfView:entity];
                                                       }];
    [alert addAction:cancelAction];
    [alert addAction:transferAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)gotoGoodsShelfView:(GoodsEntity *)entity{
    GoodsShelfViewController *svc=[[GoodsShelfViewController alloc] init];
    svc.shelf_list_model=SHELF_LIST_MODEL_PICK;
    svc.goods_entity=entity;
    self.isGotoShelvesView=YES;
    [self.navigationController pushViewController:svc animated:YES];
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
    
    if(self.isGotoShelvesView){
        self.isGotoShelvesView=NO;
        if(self.list_type==0){
            [self loadPickGoodsList];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
