//
//  HomeViewController.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/8.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "StockViewController.h"

@interface StockViewController ()

@end

@implementation StockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
    [self addNotification];
}

-(void)initData{
    
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

-(void)setUpTableView{
    self.tableView=[[SPBaseTableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN-64) style:UITableViewStylePlain];
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

-(void)loadBacthList{
    [self.model loadBacthList];
}

-(void)onResponse:(SPBaseModel *)model isSuccess:(BOOL)isSuccess{
    if(model==self.model){
        if(isSuccess){
            [self.tableView reloadData];
        }
    }
}

-(MemberLoginModel *)model{
    if(!_model){
        _model=[[MemberLoginModel alloc] init];
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
