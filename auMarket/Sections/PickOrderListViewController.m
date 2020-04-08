//
//  goodsBindViewController.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/8.
//  Copyright © 2016年 daao. All rights reserved.
//
#define CELL_ROW_HEIGHT 80.0

#import "PickOrderListViewController.h"

@interface PickOrderListViewController ()

@end

@implementation PickOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    [self initData];
}

-(void)initUI{
    [self setNavigation];
    [self setUpTableView];
}

-(void)initData{
    [self loadOrderList];
}

-(void)setNavigation{
    self.title=@"任务订单列表";
}

-(void)setUpTableView{
    float table_height=HEIGHT_SCREEN-HEIGHT_STATUS_AND_NAVIGATION_BAR;
    self.tableView=[[SPBaseTableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, table_height) style:UITableViewStylePlain];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor=COLOR_BG_TABLESEPARATE;
    self.tableView.backgroundColor=COLOR_BG_TABLEVIEW;
    [self.view addSubview:self.tableView];
    [self.tableView showTableFooterView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(WIDTH_SCREEN);
        make.bottom.mas_equalTo(0);
    }];
}



-(void)cleanTableList{
    if (!self.tableView.isLoading)
    {
        self.tableView.hasMore=YES;
        self.tableView.isEmptyLoad=NO;
        [self.tableView.itemArray removeAllObjects];
        self.tableView.isFirstLoad=YES;
        [self.tableView reloadData];
    }
}

//请求订单
-(void)loadOrderList{
    if (!self.tableView.isLoading&&!self.tableView.isEmptyLoad&&self.tableView.hasMore)
    {
        if(self.tableView.isFirstLoad){
            [self startLoadingActivityIndicator];
        }
        else{
            [self.tableView startLoadingActivityIndicatorView:nil];
        }
        [self.model loadBatchPickOrderList:self.bid];
        
        self.tableView.isLoading=YES;
    }
}

-(void)onResponse:(PickModel *)model isSuccess:(BOOL)isSuccess{
    if(model==self.model){
        if(isSuccess){
            if(self.model.pickOrderListEntity!=nil){
                [self handlerList:self.model.pickOrderListEntity];
                [self hideNoContentView];
            }
            
            if(self.tableView.itemArray==nil||self.tableView.itemArray.count<=0){
                [self showNoContentViewWithTitle:@"暂无订单数据" icon:@"SHJ_NoRequest" button:nil];
            }
        }
        
        self.tableView.isFirstLoad=NO;
        self.tableView.isLoading=NO;
        self.tableView.isPreLoading=NO;
    }
    [self stopLoadingActivityIndicator];
}

-(void)handlerList:(OrderEntity *)entity{
    if(entity!=nil&&entity.list!=nil){
        [self.tableView.itemArray addObjectsFromArray:entity.list];
        
        if(self.tableView.isFirstLoad&&self.tableView.itemArray.count<=0){
            self.tableView.isEmptyLoad=YES;
        }
        else{
            self.tableView.isEmptyLoad=NO;
        }
        
        if (self.tableView.isFirstLoad) {
            self.tableView.isFirstLoad=NO;
        }
        self.tableView.hasMore=NO;
        
        [self.tableView stopLoadingActivityIndicatorView:nil];
        //更新数据显示
        [self.tableView reloadData];
    }
}

#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(SPBaseTableView *)tv numberOfRowsInSection:(NSInteger)section
{
    if(tv.itemArray!=nil&&[tv.itemArray count]>0){
        return [tv.itemArray count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(SPBaseTableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier=@"OrderNewCellIdentifier";
    OrderItemCell *cell = [tv dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OrderItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.showsReorderControl = NO;
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.backgroundColor=COLOR_BG_TABLEVIEWCELL;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.font=FONT_SIZE_MIDDLE;
        cell.textLabel.textColor=COLOR_DARKGRAY;
    }
    OrderItemEntity *entity=[tv.itemArray objectAtIndex:indexPath.row];
    cell.entity=entity;
    return cell;
}

-(CGFloat)tableView:(SPBaseTableView *)tv heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_ROW_HEIGHT;
}

- (void)tableView:(SPBaseTableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tv deselectRowAtIndexPath:[tv indexPathForSelectedRow] animated:NO];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
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


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
