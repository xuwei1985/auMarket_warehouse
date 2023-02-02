//
//  HomeViewController.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/8.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "BatchPickViewController.h"

@interface BatchPickViewController ()

@end

@implementation BatchPickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initData];
    [self addNotification];
}

-(void)initData{
    [self loadBatchPickList];
}

-(void)initUI{
    [self setNavigation];
    [self setUpTableView];
}

-(void)setNavigation{
    if(self.listType==1){
        if(self.dataModel==2){
            self.title=@"冷冻拣货历史";
        }else{
            self.title=@"熟食拣货历史";
        }
    }
    else{
        if(self.dataModel==2){
            self.title=@"冷冻拣货";
        }else{
            self.title=@"熟食拣货";
        }
        
        doneBtn=[[UIButton alloc] initWithFrame:CGRectMake(WIDTH_SCREEN-40, 4, 40, 32)];
        [doneBtn addTarget:self action:@selector(gotoHistory) forControlEvents:UIControlEventTouchUpInside];
        [doneBtn setTitle:@"历史记录" forState:UIControlStateNormal];
        [doneBtn setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
        [doneBtn setTitleColor:COLOR_WHITE forState:UIControlStateHighlighted];
        doneBtn.titleLabel.font=FONT_SIZE_BIG;
        doneBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        
        UIBarButtonItem *right_Item_cart = [[UIBarButtonItem alloc] initWithCustomView:doneBtn];
        self.navigationItem.rightBarButtonItem=right_Item_cart;
    }
}

-(void)addNotification{
    
}

-(void)gotoHistory{
    BatchPickViewController *bvc=[[BatchPickViewController alloc] init];
    bvc.listType=1;
    bvc.dataModel=self.dataModel;
    [self.navigationController pushViewController:bvc animated:YES];
}

-(void)loadBatchPickList{
    if (!self.tableView.isLoading&&!self.tableView.isEmptyLoad&&self.tableView.hasMore)
    {
        if(self.tableView.isFirstLoad){
            if(!self.tableView.mj_header.isRefreshing){
                [self startLoadingActivityIndicator];
            }
        }
        else{
            [self.tableView startLoadingActivityIndicatorView:nil];
        }
        [self.model loadBatchPickWithListType:self.listType andModel:self.dataModel];
        
        self.tableView.isLoading=YES;
    }
    
}

-(void)reloadBatchPickList{
    if (!self.tableView.isLoading)
    {
        self.model.batchPickEntity.next=0;
        self.tableView.isFirstLoad=YES;
        self.tableView.hasMore=YES;
        self.tableView.isEmptyLoad=NO;
        [self.tableView reloadData];
        [self loadBatchPickList];
    }
    
}

-(void)handlerListPage:(BatchPickEntity *)entity{
    if(entity!=nil&&entity.list!=nil){
        [self.tableView.itemArray addObjectsFromArray:entity.list];
        //self.model.tid=entity.tid;
        //判断数据状态
        if([entity.next intValue]>0){
            self.tableView.hasMore=YES;
        }
        else{
            self.tableView.hasMore=NO;
        }
        
        if(self.tableView.isFirstLoad&&self.tableView.itemArray.count<=0){
            self.tableView.isEmptyLoad=YES;
        }
        else{
            self.tableView.isEmptyLoad=NO;
        }
        
        if (self.tableView.isFirstLoad) {
            self.tableView.isFirstLoad=NO;
        }
        
        [self.tableView stopLoadingActivityIndicatorView:nil];
        //更新数据显示
        [self.tableView reloadData];
    }
}


-(void)onResponse:(SPBaseModel *)model isSuccess:(BOOL)isSuccess{
    [self stopLoadingActivityIndicator];
    
    if(model==self.model&&model.requestTag==1010){//获取列表
        [self.tableView.mj_header endRefreshing];
        
        if(self.tableView.isFirstLoad){
            [self.tableView.itemArray removeAllObjects];
            [self.tableView reloadData];
        }
        
        if(isSuccess){
            if(self.model.entity!=nil){
                [self handlerListPage:self.model.batchPickEntity];
            }

            if(self.tableView.itemArray==nil||self.tableView.itemArray.count<=0){
                [self showNoContentViewWithTitle:@"你还没有拣货任务" icon:@"SHJ_NoRequest" button:nil];
            }
        }
        else{
            [self.tableView stopLoadingActivityIndicatorView:nil];
            [self showToastWithText:@"获取拣货任务数据失败"];
        }
        self.tableView.isFirstLoad=NO;
        self.tableView.isLoading=NO;
        self.tableView.isPreLoading=NO;
    }
}


-(void)setUpTableView{
    self.tableView=[[SPBaseTableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN-64-(self.listType==1?0:54)) style:UITableViewStylePlain];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor=COLOR_BG_LINE;
    self.tableView.backgroundColor=COLOR_BG_VIEW;
    [self.view addSubview:self.tableView];
    [self.tableView showTableFooterView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadBatchPickList)];
    
    //    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing]; // 松手刷新
    header.stateLabel.font = FONT_SIZE_SMALL;
    header.stateLabel.textColor = COLOR_DARKGRAY;
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden=YES;
    //    [header beginRefreshing];
    
    self.tableView.mj_header=header;
}

#pragma mark - Table view delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableView.itemArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 118;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdetify = @"BatchPickItemCell";
    BatchPickCell *cell =[tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (cell == nil) {
        cell=[[BatchPickCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.opaque=YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    cell.backgroundColor=COLOR_BG_WHITE;
    
    PickTaskEntity *obj=(PickTaskEntity *)[ self.tableView.itemArray objectAtIndex:indexPath.row];
    cell.entity=obj;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    PickTaskEntity *obj=(PickTaskEntity *)[self.tableView.itemArray objectAtIndex:indexPath.row];
    [self gotoBatchPickCategoryController:obj.id];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView setSeparatorInset:UIEdgeInsetsZero];
    [tableView setLayoutMargins:UIEdgeInsetsZero];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"查看订单" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        PickTaskEntity *entity=(PickTaskEntity *)[self.tableView.itemArray objectAtIndex:indexPath.row];
        [self gotoBatchPickOrderList:entity.id];
    }];
    return @[deleteAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleNone;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    // 下拉到最底部时显示更多数据
    if(self.tableView.contentOffset.y - ((self.tableView.contentSize.height - self.tableView.frame.size.height))>35&&self.tableView.itemArray.count>0 )    {
        [self loadBatchPickList];
    }
}

-(void)gotoBatchPickCategoryController:(NSString *)batch_id{
    BatchPickCategoryViewController *bvc=[[BatchPickCategoryViewController alloc] init];
    bvc.bid=batch_id;
    bvc.dataModel=self.dataModel;
    [self.navigationController pushViewController:bvc animated:YES];
}


-(void)gotoBatchPickOrderList:(NSString *)batch_id{
    PickOrderListViewController *bvc=[[PickOrderListViewController alloc] init];
    bvc.bid=batch_id;
    [self.navigationController pushViewController:bvc animated:YES];
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
