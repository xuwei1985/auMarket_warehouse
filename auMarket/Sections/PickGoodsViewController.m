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
    [self addNotification];
}

-(void)dealloc{
    [self removeNotification];
}

-(void)initUI{
    [self setNavigation];
    [self createCategoryView];
    [self setUpTableView];
}

-(void)initData{
    [self loadGoodsInBatch];
}

-(void)setNavigation{
    self.title=@"拣货";
}

-(void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadGoodsInBatch) name:@"RELOAD_GOODS_LIST" object:nil];
}

- (void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RELOAD_GOODS_LIST" object:nil];
}

-(void)createCategoryView{
    UIView *blockView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, CATEGORY_BAR)];
    blockView.backgroundColor=COLOR_BG_VIEW;
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, blockView.frame.size.height-0.5, blockView.frame.size.width, 0.5);
    layer.backgroundColor = COLOR_BG_LINE_DARK.CGColor;
    [blockView.layer addSublayer:layer];
    [self.view addSubview:blockView];
    
    
    btn_picking=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn_picking setTitle:@"拣货中" forState:UIControlStateNormal];
    btn_picking.titleLabel.textAlignment=NSTextAlignmentCenter;
    btn_picking.tintColor=COLOR_WHITE;
    btn_picking.titleLabel.font=FONT_SIZE_MIDDLE;
    [btn_picking addTarget:self action:@selector(gotoAddGoodsViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_picking];
    
    [btn_picking mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(blockView.top).offset(12);
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


//请求订单下的商品信息
-(void)loadGoodsInBatch{
    [self startLoadingActivityIndicator];
    [self.model loadBindGoodsWithBatchId:self.batch_id];
}



-(void)onResponse:(SPBaseModel *)model isSuccess:(BOOL)isSuccess{
    [self stopLoadingActivityIndicator];
    if(model==self.model&&self.model.requestTag==1002){
        if(isSuccess){
            lbl_sumPrice.text=[NSString  stringWithFormat:@"$%@",self.model.goods_list_entity.sum];
            lbl_goodsNum.text=[NSString  stringWithFormat:@"(%@件商品)",self.model.goods_list_entity.goods_count];
            [self.tableView reloadData];
        }
        else{
            [self showFailWithText:@"获取商品失败"];
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
    return self.model.goods_list_entity.list.count;
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
    
    GoodsEntity *entity=[self.model.goods_list_entity.list objectAtIndex:indexPath.row];
    cell.entity=entity;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 108;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tv deselectRowAtIndexPath:[tv indexPathForSelectedRow] animated:NO];
}


-(void)gotoAddGoodsViewController{
    StockViewController *svc=[[StockViewController alloc] init];
    svc.batch_id=self.batch_id;
    [self.navigationController pushViewController:svc animated:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
