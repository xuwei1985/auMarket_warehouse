//
//  PickViewController.m
//  auMarket
//
//  Created by 吴绪伟 on 2018/1/4.
//  Copyright © 2018年 daao. All rights reserved.
//

#import "GoodsShelfViewController.h"

@interface GoodsShelfViewController ()

@end

@implementation GoodsShelfViewController

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
    self.title=@"商品货架";
   UIBarButtonItem *right_Item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"transfer_cart"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(gotoMyCartView)];

    self.navigationItem.rightBarButtonItem=right_Item;
}

-(void)addNotification{
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTaskUpdate:) name:TASK_UPDATE_NOTIFICATION object:nil];
}

-(void)setUpTableView{
    float table_height=HEIGHT_SCREEN-64;
    self.tableView=[[SPBaseTableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN,table_height) style:UITableViewStylePlain];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor=COLOR_BG_TABLESEPARATE;
    self.tableView.backgroundColor=COLOR_BG_TABLEVIEW;
    
    UIView *view = [UIView new];
    view.backgroundColor = COLOR_CLEAR;
    
    [self.tableView setTableHeaderView:[self getGoodsView]];
    [self.tableView setTableFooterView:view];
    [self.view addSubview:self.tableView];
}

-(UIView *)getGoodsView{
    UIView *goods_view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 100)];
    goods_view.backgroundColor=COLOR_WHITE;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 99.5, WIDTH_SCREEN, 0.5);
    layer.backgroundColor = RGBCOLOR(235, 235, 235).CGColor;
    [goods_view.layer addSublayer:layer];
    
    UIImageView *goods_img=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_head.jpg"]];
    goods_img.frame=CGRectMake(12, 14, 74, 74);
    [goods_img sd_setImageWithURL:[NSURL URLWithString:self.goods_entity.goods_thumb] placeholderImage:[UIImage imageNamed:@"defaut_list"]];
    [goods_view addSubview:goods_img];
    
    UILabel *goodsNameLbl=[[UILabel alloc] initWithFrame:CGRectMake(98, 14, WIDTH_SCREEN-105 , 24)];
    goodsNameLbl.textAlignment=NSTextAlignmentLeft;
    goodsNameLbl.textColor=COLOR_DARKGRAY;
    goodsNameLbl.font=DEFAULT_FONT(14.0);
    goodsNameLbl.numberOfLines=0;
    goodsNameLbl.lineBreakMode=NSLineBreakByWordWrapping;
    goodsNameLbl.text=self.goods_entity.goods_name;
    [goodsNameLbl sizeToFit];
    [goods_view addSubview:goodsNameLbl];
    
    UILabel *goodsPriceLbl=[[UILabel alloc] initWithFrame:CGRectMake(98, 58, 100, 24)];
    goodsPriceLbl.textAlignment=NSTextAlignmentLeft;
    goodsPriceLbl.textColor=COLOR_MAIN;
    goodsPriceLbl.font=DEFAULT_FONT(14.0);
    goodsPriceLbl.text=[NSString stringWithFormat:@"$%@",self.goods_entity.shop_price];
    [goods_view addSubview:goodsPriceLbl];
    
    return goods_view;
}

-(void)selectAllOrders:(UIButton *)sender{
    
}

#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier=@"shelfCellIdentifier";
    GoodsShelfCell *cell = [tv dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[GoodsShelfCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.showsReorderControl = NO;
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.backgroundColor=COLOR_BG_TABLEVIEWCELL;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 148;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tv deselectRowAtIndexPath:[tv indexPathForSelectedRow] animated:NO];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"输入数量" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self showInputBox];
    }];
    return @[deleteAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
}


-(void)showInputBox{
    NSString *tip_title=@"";
    tip_title=@"转移数量";
    
    if (_inputAlertView==nil) {
        _inputAlertView = [[UIAlertView alloc] initWithTitle:tip_title message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    }
    _inputAlertView.title=tip_title;
    [_inputAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    UITextField *nameField = [_inputAlertView textFieldAtIndex:0];
    nameField.delegate=self;
    nameField.placeholder =[NSString stringWithFormat:@"请输入%@",tip_title];
    nameField.keyboardType=UIKeyboardTypeNumberPad;
    [_inputAlertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        UITextField *nameField = [alertView textFieldAtIndex:0];
        NSString *txt_value=[nameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [self.tableView reloadData];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //判断是否为删除字符，如果为删除则让执行
    char c=[string UTF8String][0];
    if (c=='\000') {
        //numberOfCharsLabel.text=[NSString stringWithFormat:@"%d",50-[[self.textView text] length]+1];
        return YES;
    }
    //长度限制
    if([textField.text length] > 3){
        textField.text = [textField.text substringToIndex:3];
        return NO;
    }
    
    return YES;
}


-(void)gotoMyCartView{
    
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