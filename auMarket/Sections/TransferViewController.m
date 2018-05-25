//
//  ToolsViewController.m
//  auMarket
//
//  Created by 吴绪伟 on 2018/5/19.
//  Copyright © 2018 daao. All rights reserved.
//

#import "TransferViewController.h"

@interface TransferViewController ()

@end

@implementation TransferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}

-(void)initData{
    NSMutableDictionary *dic1,*dic2,*dic3,*dic4;
    NSArray *item_childs_1,*item_childs_2,*item_childs_3,*item_childs_4;
    itemArr=[[NSMutableArray alloc] init];
    
    dic1=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"扫描商品条形码",@"item_name",@"zy_0",@"item_icon",@"",@"item_value", nil];
    dic2=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"手动搜索商品",@"item_name",@"zy_1",@"item_icon",@"",@"item_value", nil];
    dic3=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"等待转移",@"item_name",@"zy_2",@"item_icon",@"4",@"item_value", nil];
    dic4=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"转移成功",@"item_name",@"zy_3",@"item_icon",@"27",@"item_value", nil];
    
    item_childs_1=[NSArray arrayWithObjects:dic1, nil];
    item_childs_2=[NSArray arrayWithObjects:dic2, nil];
    item_childs_3=[NSArray arrayWithObjects:dic3, nil];
    item_childs_4=[NSArray arrayWithObjects:dic4, nil];
    [itemArr addObject:item_childs_1];
    [itemArr addObject:item_childs_2];
    [itemArr addObject:item_childs_3];
    [itemArr addObject:item_childs_4];
}

-(void)initUI{
    [self setNavigation];
    [self setUpTableView];
}

-(void)setNavigation{
    self.title=@"工具";
}

-(void)setUpTableView{
    float table_height=HEIGHT_SCREEN-64-48;
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
    return itemArr.count;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section
{
    return [[itemArr objectAtIndex:section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier=@"toolCellIdentifier";
    StockCell *cell = [tv dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[StockCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.showsReorderControl = YES;
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.backgroundColor=COLOR_BG_TABLEVIEWCELL;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    NSDictionary *item=[[itemArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.info_title =[item objectForKey:@"item_name"];
    cell.info_icon_name =[item objectForKey:@"item_icon"];
    cell.info_value =[item objectForKey:@"item_value"];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tv deselectRowAtIndexPath:[tv indexPathForSelectedRow] animated:YES];
    //商品条形码扫描
    if(indexPath==[NSIndexPath indexPathForRow:0 inSection:0]){
        [self gotoScanQRView:SCAN_GOODS];
    }
    else if(indexPath==[NSIndexPath indexPathForRow:0 inSection:1]){
        [self gotoGoodsSearchView];
    }
}



-(void)gotoScanQRView:(SCAN_MODEL)scan_model{
    QRCodeViewController *qvc=[[QRCodeViewController alloc] init];
    qvc.scan_model=scan_model;
    qvc.pass_delegate=self;
    [self.navigationController pushViewController:qvc animated:YES];
}

-(void)gotoGoodsSearchView{
    GoodsSearchViewController *gvc=[[GoodsSearchViewController alloc] init];
    gvc.pass_delegate=self;
    [self.navigationController pushViewController:gvc animated:YES];
}

-(void)gotoGoodsShelfView:(GoodsEntity *)entity{
    GoodsShelfViewController *gvc=[[GoodsShelfViewController alloc] init];
    gvc.goods_entity=entity;
    [self.navigationController pushViewController:gvc animated:YES];
}


//地址选择器的传值
-(void)passObject:(id)obj{
    if([obj class]==[GoodsEntity class]){
        [self gotoGoodsShelfView:(GoodsEntity*)obj];
    }
    else if(obj){
        if([[obj objectForKey:@"scan_model"] intValue]==0){//商品条形码
            self.goods_code=[obj objectForKey:@"code"];
        }
        [self.tableView reloadData];
    }
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
