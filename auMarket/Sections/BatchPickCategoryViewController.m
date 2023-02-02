//
//  ToolsViewController.m
//  auMarket
//
//  Created by 吴绪伟 on 2018/5/19.
//  Copyright © 2018 daao. All rights reserved.
//

#import "BatchPickCategoryViewController.h"

@interface BatchPickCategoryViewController ()

@end

@implementation BatchPickCategoryViewController

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
    [self setUpTableView];
}

-(void)setNavigation{
    if(self.dataModel==2){
        self.title=@"冷冻拣货分类";
    }else {
        self.title=@"熟食拣货分类";
    }
    
    
    doneBtn=[[UIButton alloc] initWithFrame:CGRectMake(WIDTH_SCREEN-40, 4, 40, 32)];
    [doneBtn addTarget:self action:@selector(pickDone:) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setTitle:@"批量完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
    [doneBtn setTitleColor:COLOR_WHITE forState:UIControlStateHighlighted];
    doneBtn.titleLabel.font=FONT_SIZE_BIG;
    doneBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    
    UIBarButtonItem *right_Item_cart = [[UIBarButtonItem alloc] initWithCustomView:doneBtn];
    self.navigationItem.rightBarButtonItem=right_Item_cart;
}

-(void)setUpTableView{
    float table_height=HEIGHT_SCREEN-64;
    self.tableView=[[SPBaseTableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN,table_height) style:UITableViewStylePlain];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor=COLOR_BG_TABLESEPARATE;
    self.tableView.backgroundColor=COLOR_BG_TABLEVIEW;
    
    UIView *view = [UIView new];
    view.backgroundColor = COLOR_CLEAR;
    
    [self.tableView setTableHeaderView:view];
    [self.tableView setTableFooterView:view];
    [self.view addSubview:self.tableView];
}


#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section
{
    return [self.model.batchPickCategoryEntity.list count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier=@"pcCellIdentifier";
    PickCategoryCell *cell = [tv dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[PickCategoryCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.showsReorderControl = NO;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor=COLOR_BG_TABLEVIEWCELL;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    PickCategoryEntity *item=[self.model.batchPickCategoryEntity.list objectAtIndex:indexPath.row];
    
    cell.entity=item;

    return cell;
}

-(CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 62;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tv deselectRowAtIndexPath:[tv indexPathForSelectedRow] animated:YES];
    [self gotoBatchGoodsPickView:[self.model.batchPickCategoryEntity.list objectAtIndex:indexPath.row]];
    
}


-(void)loadOrders{
    if(!self.tableView.isLoading){
        [self startLoadingActivityIndicator];
        [self.model loadBatchPickCategory:self.bid andModel:self.dataModel];
    }
}

-(void)pickDone:(id)seder{
    [self startLoadingActivityIndicator];
    [self.model batchPickDone:self.bid];
}


-(void)onResponse:(SPBaseModel *)model isSuccess:(BOOL)isSuccess{
    [self stopLoadingActivityIndicator];
    
    if(model==self.model){
        if(model.requestTag==1011){
            self.tableView.isLoading=NO;
            [self stopLoadingActivityIndicator];
            
            if(self.model.batchPickCategoryEntity.list!=nil){
                [self.tableView reloadData];
                if([self.model.batchPickCategoryEntity.list count]<=0){
                    [self showNoContentView];
                }else{
                    [self hideNoContentView];
                }
            }else{
                [self.tableView reloadData];
                [self showNoContentView];
            }
        }else if(model.requestTag==1012){
            [self stopLoadingActivityIndicator];
            if([self.model.pickDoneEntity.code intValue]==200){
                [SVProgressHUD showSuccessWithStatus:@"操作成功"];
            }else{
                [SVProgressHUD showErrorWithStatus:@"操作失败"];
            }
            
        }
    }
}


-(void)gotoBatchGoodsPickView:(PickCategoryEntity *)entity{
    BatchGoodsPickViewController *gvc=[[BatchGoodsPickViewController alloc] init];
    gvc.b_id=self.bid;
    gvc.cat_id=entity.cat_id;
    [self.navigationController pushViewController:gvc animated:YES];
}


-(PickModel *)model{
    if(!_model){
        _model=[[PickModel alloc] init];
        _model.delegate=self;
    }
    return _model;
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
