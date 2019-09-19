//
//  PickViewController.m
//  auMarket
//
//  Created by 吴绪伟 on 2018/1/4.
//  Copyright © 2018年 daao. All rights reserved.
//
#define TOOLBAR_HEIGHT (IS_IPhoneX?123.0f:84.0f)
#import "InventoryCheckViewController.h"

@interface InventoryCheckViewController ()

@end

@implementation InventoryCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initData];
}

-(void)initData{
    
}

-(void)initUI{
    [self setNavigation];
    [self createScanGoodsView];
    [self setUpTableView];
}

-(void)setNavigation{
    self.title=@"盘点库存";
}

-(void)createScanGoodsView{
    scanGoodsImg=[[UIImageView alloc] init];
    scanGoodsImg.image=[UIImage imageNamed:@"scan_goods.jpg"];
    scanGoodsImg.clipsToBounds=YES;
    scanGoodsImg.layer.cornerRadius = 14;
    scanGoodsImg.userInteractionEnabled=YES;
    [self.view addSubview:scanGoodsImg];
    
    [scanGoodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(-30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(120, 120));
    }];
    
    [scanGoodsImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoScanQRView)]];
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

-(UIView *)getGoodsView{
    UIView *goods_view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 100)];
    goods_view.backgroundColor=COLOR_WHITE;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 99.5, WIDTH_SCREEN, 0.5);
    layer.backgroundColor = RGBCOLOR(230, 230, 230).CGColor;
    [goods_view.layer addSublayer:layer];
    
    NSURL *img_url=[NSURL URLWithString:self.goods_entity.goods_thumb];
    goods_img=[[UIImageView alloc] init];
    goods_img.frame=CGRectMake(10, 12, 78, 78);
    [goods_img sd_setImageWithURL:img_url placeholderImage:[UIImage imageNamed:@"defaut_list"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    [goods_view addSubview:goods_img];
    
    goodsNameLbl=[[UILabel alloc] initWithFrame:CGRectMake(98, 14, WIDTH_SCREEN-105 , 24)];
    goodsNameLbl.textAlignment=NSTextAlignmentLeft;
    goodsNameLbl.textColor=COLOR_DARKGRAY;
    goodsNameLbl.font=DEFAULT_FONT(15.0);
    goodsNameLbl.numberOfLines=0;
    goodsNameLbl.lineBreakMode=NSLineBreakByWordWrapping;
    goodsNameLbl.text=self.goods_entity.goods_name;
    [goodsNameLbl sizeToFit];
    [goods_view addSubview:goodsNameLbl];
    
    goodsPriceLbl=[[UILabel alloc] initWithFrame:CGRectMake(98, 62, 100, 24)];
    goodsPriceLbl.textAlignment=NSTextAlignmentLeft;
    goodsPriceLbl.textColor=COLOR_MAIN;
    goodsPriceLbl.font=DEFAULT_FONT(14.0);
    goodsPriceLbl.text=[NSString stringWithFormat:@"$%@",self.goods_entity.shop_price];
    [goods_view addSubview:goodsPriceLbl];
    
    goodsNumLbl=[[UILabel alloc] initWithFrame:CGRectMake(WIDTH_SCREEN-100, 62, 90, 24)];
    goodsNumLbl.textAlignment=NSTextAlignmentRight;
    goodsNumLbl.textColor=COLOR_DARKGRAY;
    goodsNumLbl.font=DEFAULT_BOLD_FONT(13);
    goodsNumLbl.text=[NSString stringWithFormat:@"库存:%@",self.goods_entity.number];
    [goods_view addSubview:goodsNumLbl];
    
    return goods_view;
}

-(UIView *)getGoodsFooterView{
    UIView *goods_footer_view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 40)];
    goods_footer_view.backgroundColor=COLOR_WHITE;
    
    btn_adjustInventory=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn_adjustInventory setTitle:@"调整库存" forState:UIControlStateNormal];//正常状态
    btn_adjustInventory.backgroundColor = [UIColor colorWithString:@"#E94132"];
    [btn_adjustInventory setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
    [btn_adjustInventory setTintColor:[UIColor whiteColor]];
    btn_adjustInventory.titleLabel.font = [UIFont systemFontOfSize:15];
    [goods_footer_view addSubview:btn_adjustInventory];
    [btn_adjustInventory addTarget:self action:@selector(showInventoryView) forControlEvents:UIControlEventTouchUpInside];
    
    [btn_adjustInventory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(0.5*WIDTH_SCREEN, 40));
    }];
    
    UIButton *btn_next=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn_next setTitle:@"继续扫描" forState:UIControlStateNormal];//正常状态
    btn_next.backgroundColor = [UIColor colorWithString:@"#57BE6A"];
    [btn_next setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
    [btn_next setTintColor:[UIColor whiteColor]];
    btn_next.titleLabel.font = [UIFont systemFontOfSize:15];
    [goods_footer_view addSubview:btn_next];
    [btn_next addTarget:self action:@selector(gotoScanQRView) forControlEvents:UIControlEventTouchUpInside];
    
    [btn_next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0.5*WIDTH_SCREEN);
        make.size.mas_equalTo(CGSizeMake(0.5*WIDTH_SCREEN, 40));
    }];
    return goods_footer_view;
}


-(void)updateGoodsBasicInfo{
    [goods_img sd_setImageWithURL:[NSURL URLWithString:self.goods_entity.goods_thumb] placeholderImage:[UIImage imageNamed:@"defaut_list"]];
    goodsNameLbl.text=self.goods_entity.goods_name;
    goodsPriceLbl.text=[NSString stringWithFormat:@"$%@",self.goods_entity.shop_price];
    [goodsNameLbl sizeToFit];
    [self.tableView reloadData];
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
    NSString *identifier=@"checkCellIdentifier";
    InventoryCheckCell *cell = [tv dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[InventoryCheckCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.showsReorderControl = NO;
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.backgroundColor=COLOR_BG_TABLEVIEWCELL;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ShelfItemEntity *entity=[self.model.entity.list objectAtIndex:indexPath.row];
    cell.entity=entity;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 128;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tv deselectRowAtIndexPath:[tv indexPathForSelectedRow] animated:NO];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"输入数量" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        self.inputPath=indexPath;
//    }];
//    return @[deleteAction];
    return nil;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
}


-(void)loadGoodsShelves{
    [self.model goodsShelfList:self.goods_entity.goods_id andGoodsCode:self.goods_entity.goods_code andShelf:self.goods_entity.shelves_no];
}

-(void)searchGoodsWithCode:(NSString *)goods_code{
    if(self.goods_code&&self.goods_code.length>0){
        [self startLoadingActivityIndicator];
        [self.goods_model loadGoodsList:self.goods_code orGoodsName:nil];
    }
}

-(void)adjustInventory{
    if(_adjustmModel>0){
        [self showMaskView];
        [self startLoadingActivityIndicator];
        [self.goods_model adjustInventory:self.goods_entity.goods_id andNum:_adjustNum andAction:_adjustmModel];
    }
}

-(void)onResponse:(SPBaseModel *)model isSuccess:(BOOL)isSuccess{
    if(model==self.model){
        [self hideMaskView];
        [self stopLoadingActivityIndicator];
        if(model.requestTag==1001){//获取货架列表
            if(isSuccess){
                if(self.model.entity.list!=nil&&self.model.entity.list.count>0){
                    [self.tableView reloadData];
                }
                else{
                    [self.tableView reloadData];
                }
            }
        }
    }
    else if(model==self.goods_model){
        if(model.requestTag==1001){//获取到商品信息
            if(self.goods_model.entity.list!=nil&&self.goods_model.entity.list.count>0){
                self.goods_entity=[self.goods_model.entity.list objectAtIndex:0];

                [self.tableView setTableFooterView:[self getGoodsFooterView]];
                [self.tableView setTableHeaderView:[self getGoodsView]];
                [self.tableView reloadData];
                [self showGoodsShelfData:YES];
                [self loadGoodsShelves];
            }
            else{
                [self stopLoadingActivityIndicator];
                [self showFailWithText:@"未匹配到已有商品"];
            }
        }
        else if(model.requestTag==1002){
            if([self.goods_model.i_entity.code intValue]==0){
                [self searchGoodsWithCode:self.goods_code];
                [self loadGoodsShelves];
            }
            else{
                [self hideMaskView];
                [self stopLoadingActivityIndicator];
                [self showFailWithText:self.goods_model.i_entity.msg];
            }
        }
    }
}

-(void)showGoodsShelfData:(BOOL)show{
    if(show){
        self.tableView.hidden=NO;
        scanGoodsImg.hidden=YES;
    }
    else{
        self.tableView.hidden=YES;
        scanGoodsImg.hidden=NO;
    }
}

-(void)showInventoryView{
    //初始化
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"调整库存数量" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"增加库存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *inv_num = alertController.textFields.firstObject;
        _adjustNum=[inv_num.text intValue];
        _adjustmModel=2;
        if(_adjustNum>0){
            [self adjustInventory];
        }
        else{
            [self showToastWithText:@"无效的库存数"];
        }
    }];
    
    UIAlertAction *structAction = [UIAlertAction actionWithTitle:@"减少库存" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        UITextField *inv_num = alertController.textFields.firstObject;
        _adjustNum=[inv_num.text intValue];
        _adjustmModel=1;
        if(_adjustNum>0){
            [self adjustInventory];
        }
        else{
            [self showToastWithText:@"无效的库存数"];
        }
    }];
    
    //取消按钮（只能创建一个）
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    //将按钮添加到UIAlertController对象上
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    [alertController addAction:structAction];
    
    //添加文本框（只能在UIAlertController的UIAlertControllerStyleAlert样式下添加）
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"填写变动的库存数量";
        textField.font=FONT_SIZE_MIDDLE;
        textField.textAlignment=NSTextAlignmentCenter;
        textField.delegate=self;
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];

    //显示弹窗视图控制器
    [self presentViewController:alertController animated:YES completion:nil];
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
    if([textField.text length] >= 4){
        textField.text = [textField.text substringToIndex:4];
        return NO;
    }
    
    return YES;
}

-(void)gotoScanQRView{
    QRCodeViewController *qvc=[[QRCodeViewController alloc] init];
    qvc.scan_model=SCAN_GOODS;
    qvc.pass_delegate=self;
    [self.navigationController pushViewController:qvc animated:YES];
}


-(void)passObject:(id)obj{
     if(obj){
        if([[obj objectForKey:@"scan_model"] intValue]==SCAN_GOODS){//商品条形码
            self.model.entity.list=nil;
            [self.tableView reloadData];
            self.goods_code=[obj objectForKey:@"code"];
            [self searchGoodsWithCode:self.goods_code];
        }
    }
}

-(TransferModel *)model{
    if(!_model){
        _model=[[TransferModel alloc] init];
        _model.delegate=self;
    }
    return _model;
}

-(GoodsListModel *)goods_model{
    if(!_goods_model){
        _goods_model=[[GoodsListModel alloc] init];
        _goods_model.delegate=self;
    }
    return _goods_model;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.goods_entity==nil){
        [self showGoodsShelfData:NO];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
