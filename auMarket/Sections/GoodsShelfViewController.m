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
    
    [self initUI];
    [self initData];
    [self addNotification];
}

-(void)initData{
    [self loadGoodsShelves];
    
}

-(void)initUI{
    [self setNavigation];
    [self setUpTableView];
}

-(void)setNavigation{
    self.title=@"商品货架";
    
    UIBarButtonItem *right_Item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"transfer_cart"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(gotoTransferGoodsView)];
    
    self.navigationItem.rightBarButtonItem=right_Item;
    
    lbl_transfer_num=[[UILabel alloc] initWithFrame:CGRectMake(WIDTH_SCREEN-25, 20, 14, 14)];
    lbl_transfer_num.text=@"0";
    lbl_transfer_num.font=DEFAULT_FONT(11);
    lbl_transfer_num.textColor=COLOR_MAIN;
    lbl_transfer_num.textAlignment=NSTextAlignmentCenter;
    lbl_transfer_num.backgroundColor=COLOR_BG_WHITE;
    [lbl_transfer_num.layer setCornerRadius:7];
    lbl_transfer_num.clipsToBounds=YES;
    lbl_transfer_num.hidden=YES;
    [self.navigationController.view addSubview:lbl_transfer_num];
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


#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section
{
    return [self.model.entity.list count];
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
    ShelfItemEntity *entity=[self.model.entity.list objectAtIndex:indexPath.row];
    cell.entity=entity;
    [cell addStack:^(NSString *ruku_id, NSString *number) {
        if([ruku_id length]>0&&[number intValue]>0){
            [self addTransferToStack:ruku_id andNumber:number];
        }
        else{
            [self showToastWithText:@"请先侧滑输入转移数量"];
        }
    }];
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
        self.inputPath=indexPath;
        [self showInputBox];
    }];
    return @[deleteAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
}


-(void)loadGoodsShelves{
    [self startLoadingActivityIndicator];
    [self.model goodsShelfList:self.goods_entity.goods_id andGoodsCode:self.goods_entity.goods_code andShelf:self.goods_entity.shelves_no];
}

//请求需要转移的商品列表
-(void)loadTransferGoodsList{
    [self.model goodsTransferList:0 andTargetShelf:self.from_pick?self.goods_entity.shelves_no:@""];
}


-(void)addTransferToStack:(NSString *)ruku_id andNumber:(NSString *)num{
    [self startLoadingActivityIndicator];
    
    NSString *new_shelf_code=@"";
    if(self.from_pick){
        new_shelf_code=self.goods_entity.shelves_no;
    }
    [self.model addTransferToStack:ruku_id andNumber:num andNewShelf:new_shelf_code];
}

-(void)onResponse:(SPBaseModel *)model isSuccess:(BOOL)isSuccess{
    [self stopLoadingActivityIndicator];
    
    if(model==self.model){
        if(model.requestTag==1001){//获取货架列表
            if(isSuccess){
                if(self.model.entity.list!=nil&&self.model.entity.list.count>0){
                    [self.tableView reloadData];
                    [self hideNoContentView];
                }
                else{
                    [self showNoContentView];
                }
                [self loadTransferGoodsList];
            }
        }
        else if(model.requestTag==1002){//添加到待转移区域
            if(isSuccess){
                [self showSuccesWithText:@"添加成功"];
                [self loadGoodsShelves];
            }
            else{
                [self showFailWithText:@"加入待转移失败"];
            }
        }
        else if(model.requestTag==1003){//获取带转移商品列表
            if(isSuccess){
                if(self.model.transfer_entity.list!=nil&&self.model.transfer_entity.list.count>0){
                    lbl_transfer_num.hidden=NO;
                    lbl_transfer_num.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.model.transfer_entity.list.count];
                    if([lbl_transfer_num.text intValue]<99){
                        lbl_transfer_num.frame=CGRectMake(WIDTH_SCREEN-25, 20, 14, 14);
                    }
                    else{
                        lbl_transfer_num.frame=CGRectMake(WIDTH_SCREEN-25, 20, 22, 14);
                    }
                }
                else{
                    lbl_transfer_num.hidden=YES;
                }
            }
        }
    }
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
        
        if([txt_value intValue]<=0){
            [self showToastWithText:@"转移数量应大于0"];
        }
        else if([txt_value intValue]>[[self.model.entity.list objectAtIndex:self.inputPath.row].inventory intValue]){
            [self showToastWithText:@"超过了该货架的商品库存"];
        }
        else{
            [self.model.entity.list objectAtIndex:self.inputPath.row].transfer_number=[NSString stringWithFormat:@"%d",[txt_value intValue]];
            [self.tableView reloadData];
        }
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


-(void)gotoTransferGoodsView{
    TransferGoodsViewController *tvc=[[TransferGoodsViewController alloc] init];
    tvc.list_type=0;
    tvc.target_shelf=self.goods_entity.shelves_no;
    [self.navigationController pushViewController:tvc animated:YES];
}

-(TransferModel *)model{
    if(!_model){
        _model=[[TransferModel alloc] init];
        _model.delegate=self;
    }
    return _model;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if([lbl_transfer_num.text intValue]>0){
       lbl_transfer_num.hidden=NO;
    }
    
    if(self.from_pick){
        [self loadGoodsShelves];
    }
}


-(void)viewWillDisappear:(BOOL)animated{
    lbl_transfer_num.hidden=YES;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
