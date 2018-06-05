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
    dic3=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"等待转移",@"item_name",@"zy_2",@"item_icon",@"",@"item_value", nil];
    dic4=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"转移成功",@"item_name",@"zy_3",@"item_icon",@"",@"item_value", nil];
    
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
        cell.showsReorderControl = NO;
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
    if([indexPath compare:[NSIndexPath indexPathForRow:0 inSection:0]]==NSOrderedSame){
        [self gotoScanQRView:SCAN_GOODS];
    }
    else if([indexPath compare:[NSIndexPath indexPathForRow:0 inSection:1]]==NSOrderedSame){
        [self gotoGoodsSearchView];
    }
    else if([indexPath compare:[NSIndexPath indexPathForRow:0 inSection:2]]==NSOrderedSame){
        [self gotoTransferGoodsView:0];
    }
    else if([indexPath compare:[NSIndexPath indexPathForRow:0 inSection:3]]==NSOrderedSame){
        [self gotoTransferGoodsView:1];
    }
}

-(void)searchGoodsWithCode:(NSString *)goods_code{
    //执行搜索
    if(goods_code&&goods_code.length>0){
        [self startLoadingActivityIndicator];
        [self.goods_model loadGoodsList:goods_code orGoodsName:nil];
    }
}

-(void)onResponse:(SPBaseModel *)model isSuccess:(BOOL)isSuccess{
    [self stopLoadingActivityIndicator];
    
    if(model==self.goods_model){
        if(model.requestTag==1001){
            if(self.goods_model.entity.list!=nil&&self.goods_model.entity.list.count>0){
                self.scan_entity=[self.goods_model.entity.list objectAtIndex:0];
                self.goods_id=self.scan_entity.goods_id;
                
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC));
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    [self gotoGoodsShelfView:self.scan_entity];
                });
            }
            else{
                [self showFailWithText:@"未匹配到已有商品"];
            }
        }
    }
}

-(void)gotoTransferGoodsView:(int)list_type{
    TransferGoodsViewController *tvc=[[TransferGoodsViewController alloc] init];
    tvc.list_type=list_type;
    [self.navigationController pushViewController:tvc animated:YES];
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
    GoodsShelfViewController *svc=[[GoodsShelfViewController alloc] init];
    svc.goods_entity=entity;
    [self.navigationController pushViewController:svc animated:YES];
}


//地址选择器的传值
-(void)passObject:(id)obj{
    if([obj class]==[GoodsEntity class]){
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [self gotoGoodsShelfView:(GoodsEntity*)obj];
        });
    }
    else if(obj){
        if([[obj objectForKey:@"scan_model"] intValue]==SCAN_GOODS){//商品条形码
            self.goods_code=[obj objectForKey:@"code"];
            [self searchGoodsWithCode:self.goods_code];
        }
        [self.tableView reloadData];
    }
}

-(GoodsListModel *)goods_model{
    if(!_goods_model){
        _goods_model=[[GoodsListModel alloc] init];
        _goods_model.delegate=self;
    }
    return _goods_model;
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
