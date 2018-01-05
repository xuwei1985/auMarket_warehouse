//
//  HomeViewController.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/8.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "BatchViewController.h"

@interface BatchViewController ()

@end

@implementation BatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initData];
    [self addNotification];
}

-(void)initData{
    [self loadBatchList];
}

-(void)initUI{
    [self setNavigation];
    [self setUpTableView];
}

-(void)setNavigation{
    self.title=@"入库";
}

-(void)addNotification{
    
}

-(void)loadBatchList{
    if (!self.tableView.isLoading&&!self.tableView.isEmptyLoad&&self.tableView.hasMore)
    {
        if(self.tableView.isFirstLoad){
            [self startLoadingActivityIndicator];
        }
        else{
            [self.tableView startLoadingActivityIndicatorView:nil];
        }
        [self.model loadBatchs];
        
        self.tableView.isLoading=YES;
    }
}

-(void)handlerListPage:(BatchEntity *)entity{
    if(entity!=nil&&entity.list!=nil){
        [self.tableView.itemArray addObjectsFromArray:entity.list];
        //self.model.tid=entity.tid;
        //判断数据状态
        if([entity.tid intValue]>0){
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
    
    if(model==self.model&&model.requestTag==1001){//获取列表
        if(isSuccess){
            if(self.model.entity!=nil){
                [self handlerListPage:self.model.entity];
            }
            else{
                NSLog(@"未获取到订单数据");
            }
            
            if(self.tableView.itemArray==nil||self.tableView.itemArray.count<=0){
                [self showNoContentViewWithTitle:@"你还没有订单信息！" icon:@"SHJ_NoRequest" button:nil];
            }
        }
        else{
            [self.tableView stopLoadingActivityIndicatorView:nil];
            [self showToastBottomWithText:@"获取订单数据失败"];
        }
        self.tableView.isFirstLoad=NO;
        self.tableView.isLoading=NO;
        self.tableView.isPreLoading=NO;
    }
}


-(void)setUpTableView{
    self.tableView=[[SPBaseTableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN-64-54) style:UITableViewStylePlain];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor=COLOR_BG_LINE;
    self.tableView.backgroundColor=COLOR_BG_VIEW;
    [self.view addSubview:self.tableView];
    [self.tableView showTableFooterView];
}

#pragma mark - Table view delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableView.itemArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 92;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdetify = @"StockItemCell";
    BatchCell *cell =[tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (cell == nil) {
        cell=[[BatchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.opaque=YES;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.backgroundColor=COLOR_BG_WHITE;
    
    BatchItemEntity *obj=(BatchItemEntity *)[ self.tableView.itemArray objectAtIndex:indexPath.row];
    cell.entity=obj;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BatchItemEntity *obj=(BatchItemEntity *)[ self.tableView.itemArray objectAtIndex:indexPath.row];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView setSeparatorInset:UIEdgeInsetsZero];
    [tableView setLayoutMargins:UIEdgeInsetsZero];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    // 下拉到最底部时显示更多数据
    if(self.tableView.contentOffset.y - ((self.tableView.contentSize.height - self.tableView.frame.size.height))>35&&self.tableView.itemArray.count>0 )    {
        [self loadBatchList];
    }
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
