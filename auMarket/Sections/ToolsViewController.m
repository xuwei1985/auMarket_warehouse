//
//  ToolsViewController.m
//  auMarket
//
//  Created by 吴绪伟 on 2018/5/19.
//  Copyright © 2018 daao. All rights reserved.
//

#import "ToolsViewController.h"

@interface ToolsViewController ()

@end

@implementation ToolsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}

-(void)initData{
    NSMutableDictionary *dic1,*dic2;
    NSArray *item_childs_1,*item_childs_2;
    itemArr=[[NSMutableArray alloc] init];
    
    dic1=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"库存转移",@"item_name",@"goods_tansfer",@"item_icon",@"",@"item_value", nil];
    dic2=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"盘点库存",@"item_name",@"goods_tansfer",@"item_icon",@"",@"item_value", nil];
    
    item_childs_1=[NSArray arrayWithObjects:dic1, nil];
    item_childs_2=[NSArray arrayWithObjects:dic2, nil];
    
    Booter *bt=[[Booter alloc] init];
    if([bt checkMenu:@"inventory_move"])
    {
        [itemArr addObject:item_childs_1];
        [itemArr addObject:item_childs_2];
    }
    
}

-(void)initUI{
    [self setNavigation];
    [self setUpTableView];
    
    if([itemArr count]<=0){
        [self showNoContentView];
    }
    else{
        [self hideNoContentView];
    }
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
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.showsReorderControl = NO;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor=COLOR_BG_TABLEVIEWCELL;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    NSDictionary *item=[[itemArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.imageView.image=[UIImage imageNamed:[item objectForKey:@"item_icon"]];
    cell.textLabel.text=[item objectForKey:@"item_name"];
    CGSize itemSize = CGSizeMake(36, 36);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 3.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return cell;
}

-(CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tv deselectRowAtIndexPath:[tv indexPathForSelectedRow] animated:YES];
    if(indexPath.section==0){
        [self gotoTransferView];
    }
    else if(indexPath.section==2){
        [self gotoCheckInventoryView];
    }
}

-(void)gotoTransferView{
    TransferViewController *tvc=[[TransferViewController alloc] init];
    [self.navigationController pushViewController:tvc animated:YES];
}

-(void)gotoCheckInventoryView{
    InventoryCheckViewController *tvc=[[InventoryCheckViewController alloc] init];
    [self.navigationController pushViewController:tvc animated:YES];
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
