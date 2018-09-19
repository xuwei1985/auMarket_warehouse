//
//  StockViewController.m
//  auMarket
//
//  Created by 吴绪伟 on 2018/1/10.
//  Copyright © 2018年 daao. All rights reserved.
//

#import "StockViewController.h"

@interface StockViewController ()

@end

@implementation StockViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initData];
}


-(void)initData{
    NSMutableDictionary *dic1,*dic2,*dic3,*dic4,*dic5,*dic6,*dic7,*dic8,*dic9;
    NSArray *item_childs_1,*item_childs_2,*item_childs_3;
    itemArr=[[NSMutableArray alloc] init];
    
    dic1=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"扫一扫",@"item_name",@"stock_scan",@"item_icon",@"",@"item_value", nil];
    dic2=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"手动输入",@"item_name",@"stock_edit",@"item_icon",@"",@"item_value", nil];
    dic3=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"商品搜索",@"item_name",@"stock_scan",@"item_icon",@"",@"item_value", nil];
    dic4=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"列表编号",@"item_name",@"stock_listnum",@"item_icon",@"",@"item_value", nil];
    dic5=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"商品进价",@"item_name",@"stock_mark",@"item_icon",@"",@"item_value", nil];
    dic6=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"商品数量",@"item_name",@"stock_money",@"item_icon",@"",@"item_value", nil];
    dic7=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"保质期",@"item_name",@"stock_date",@"item_icon",@"",@"item_value", nil];
    dic8=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"扫一扫",@"item_name",@"stock_scan",@"item_icon",@"",@"item_value", nil];
    dic9=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"手动输入",@"item_name",@"stock_edit",@"item_icon",@"",@"item_value", nil];

    item_childs_1=[NSArray arrayWithObjects:dic1,dic9,dic3, nil];
    item_childs_2=[NSArray arrayWithObjects:dic4,dic5,dic6,dic7, nil];
    item_childs_3=[NSArray arrayWithObjects:dic8,dic9, nil];
    [itemArr addObject:item_childs_1];
    [itemArr addObject:item_childs_2];
    [itemArr addObject:item_childs_3];
}

-(void)initUI{
    [self setNavigation];
    [self setUpTableView];
}

-(void)setNavigation{
    self.title=@"商品信息";
}

-(void)loadGoodsInfoByCode{
    [self.model loadBatchs];
}

-(void)resetData{
    self.goods_id=@"";
    self.goods_code=@"";
    self.shelf_code=@"";
    self.scan_entity=nil;
    
    for (int i=0; i<itemArr.count; i++) {
        [[itemArr objectAtIndex:i] setValue:@"" forKey:@"item_value"];
    }
}

-(void)onResponse:(SPBaseModel *)model isSuccess:(BOOL)isSuccess{
    [self stopLoadingActivityIndicator];
    
    if(model==self.model){//获取列表
        if(model.requestTag==1003){
            [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
            
            if(isSuccess){
                [self showSuccesWithText:@"入库保存成功"];
                if(self.save_model==SAVE_THEN_BACK){
                    [self goBack];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"RELOAD_GOODS_LIST" object:nil];
                }
                else{
                    [self resetData];
                    [self.tableView reloadData];
                }
            }
        }
    }
    else if(model==self.goods_model){
        if(model.requestTag==1001){
            if(self.goods_model.entity.list!=nil&&self.goods_model.entity.list.count>0){
                self.scan_entity=[self.goods_model.entity.list objectAtIndex:0];
                self.goods_id=self.scan_entity.goods_id;
                [self.tableView reloadData];
            }
            else{
                [self showFailWithText:@"未匹配到已有商品"];
            }
        }
    }
}

-(void)setUpTableView{
    self.tableView=[[SPBaseTableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN-64-48) style:UITableViewStylePlain];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor=COLOR_BG_TABLESEPARATE;
    self.tableView.backgroundColor=COLOR_BG_VIEW;
    [self.view addSubview:self.tableView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 15)];
    view.backgroundColor = COLOR_CLEAR;
    [self.tableView setTableFooterView:view];
    
    _btn_back=[UIButton buttonWithType:UIButtonTypeCustom];
    [_btn_back setTitle:@"完成并返回" forState:UIControlStateNormal];
    [_btn_back setBackgroundColor:RGBCOLOR(255, 255, 255)];
    [_btn_back setTitleColor:COLOR_MAIN forState:UIControlStateNormal];
    _btn_back.frame=CGRectMake(0, HEIGHT_SCREEN-64-48, WIDTH_SCREEN/2, 48);
    _btn_back.titleLabel.font=FONT_SIZE_MIDDLE;
    _btn_back.titleLabel.textAlignment=NSTextAlignmentCenter;
    _btn_back.tag=3001;
    [_btn_back addTarget:self action:@selector(nextGoods:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn_back];
    
    _btn_next=[UIButton buttonWithType:UIButtonTypeCustom];
    [_btn_next setTitle:@"完成并继续" forState:UIControlStateNormal];
    [_btn_next setBackgroundColor:COLOR_MAIN];
    [_btn_next setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
    _btn_next.frame=CGRectMake(WIDTH_SCREEN/2, HEIGHT_SCREEN-64-48, WIDTH_SCREEN/2, 48);
    _btn_next.titleLabel.font=FONT_SIZE_BIG;
    _btn_next.titleLabel.textAlignment=NSTextAlignmentCenter;
    _btn_next.tag=3002;
    [_btn_next addTarget:self action:@selector(nextGoods:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn_next];
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
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section==0&&self.scan_entity){
        return 92;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *txt_section_title=@"";
    NSString *txt_section_value=@"";
    
    if(section==0){
        txt_section_title=@"商品条形码";
        txt_section_value=self.goods_code;
    }
    else if(section==1){
        txt_section_title=@"商品信息";
    }
    else if(section==2){
        txt_section_title=@"货架信息";
        txt_section_value=self.shelf_code;
    }
    UIView *section_header_view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 60)];
    section_header_view.backgroundColor=COLOR_WHITE;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 59.5, WIDTH_SCREEN, 0.5);
    layer.backgroundColor = RGBCOLOR(235, 235, 235).CGColor;
    [section_header_view.layer addSublayer:layer];
    
    UIView *splitView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 14)];
    splitView.backgroundColor=COLOR_BG_TABLEVIEW;
    [section_header_view addSubview:splitView];
    
    
    UILabel *section_title=[[UILabel alloc] initWithFrame:CGRectMake(10, 14, 100, 46)];
    section_title.textColor=COLOR_MAIN;
    section_title.text=txt_section_title;
    section_title.textAlignment=NSTextAlignmentLeft;
    [section_header_view addSubview:section_title];
    
    UILabel *section_value=[[UILabel alloc] initWithFrame:CGRectMake(WIDTH_SCREEN-160, 14, 150, 46)];
    section_value.textColor=COLOR_DARKGRAY;
    section_value.text=txt_section_value;
    section_value.textAlignment=NSTextAlignmentRight;
    section_value.font=FONT_SIZE_SMALL;
    [section_header_view addSubview:section_value];
    
    return section_header_view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section==0&&self.scan_entity){
        goods_view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 92)];
        goods_view.backgroundColor=COLOR_WHITE;
        goods_view.userInteractionEnabled=YES;
        [goods_view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoGoodsShelfView)]];
        
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, WIDTH_SCREEN, 0.5);
        layer.backgroundColor = RGBCOLOR(235, 235, 235).CGColor;
        [goods_view.layer addSublayer:layer];
         
        goods_img=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_head.jpg"]];
        goods_img.frame=CGRectMake(10, 10, 72, 72);
        [goods_view addSubview:goods_img];
        
        goodsNameLbl=[[UILabel alloc] initWithFrame:CGRectMake(92, 10, WIDTH_SCREEN-105 , 24)];
        goodsNameLbl.textAlignment=NSTextAlignmentLeft;
        goodsNameLbl.textColor=COLOR_DARKGRAY;
        goodsNameLbl.font=DEFAULT_FONT(14.0);
        goodsNameLbl.numberOfLines=0;
        goodsNameLbl.lineBreakMode=NSLineBreakByWordWrapping;
        [goods_view addSubview:goodsNameLbl];
        
        goodsPriceLbl=[[UILabel alloc] initWithFrame:CGRectMake(92, 58, 100, 24)];
        goodsPriceLbl.textAlignment=NSTextAlignmentLeft;
        goodsPriceLbl.textColor=COLOR_DARKGRAY;
        goodsPriceLbl.font=DEFAULT_FONT(14.0);
        [goods_view addSubview:goodsPriceLbl];
        
        if(self.scan_entity){
            [goods_img sd_setImageWithURL:[NSURL URLWithString:self.scan_entity.goods_thumb] placeholderImage:[UIImage imageNamed:@"defaut_list"]];
            goodsNameLbl.text=self.scan_entity.goods_name;
            goodsPriceLbl.text=[NSString stringWithFormat:@"库存：%@",self.scan_entity.number];
            [goodsNameLbl sizeToFit];
        }
        else{
            goodsNameLbl.text=@"";
            goodsPriceLbl.text=@"$0.00";
        }
        
        return goods_view;
        
    }
    return nil;
}

//设置每行每列的值
- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier=@"StockCellIdentifier";
    StockCell *cell = [tv dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[StockCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.showsReorderControl = NO;
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.backgroundColor=COLOR_BG_TABLEVIEWCELL;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.font=DEFAULT_FONT(16.0);
        cell.textLabel.textColor=COLOR_DARKGRAY;
    }

    cell.info_title =[[[itemArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"item_name"];
    cell.info_icon_name =[[[itemArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"item_icon"];
    cell.info_value =[[[itemArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"item_value"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tv deselectRowAtIndexPath:[tv indexPathForSelectedRow] animated:YES];
    
    
    if(indexPath==[NSIndexPath indexPathForRow:3 inSection:1]){//保质期选择
        [self showDatePicker];
    }
    else{
        //商品条形码扫描
        if([indexPath compare:[NSIndexPath indexPathForRow:0 inSection:0]]==NSOrderedSame){
            [self gotoScanQRView:SCAN_GOODS];
        }
        else if([indexPath compare:[NSIndexPath indexPathForRow:1 inSection:0]]==NSOrderedSame){
            [self showInputBox:INPUT_GOODS_CODE];
        }
        else if([indexPath compare:[NSIndexPath indexPathForRow:2 inSection:0]]==NSOrderedSame){
            [self gotoGoodsSearchView];
        }
        else if([indexPath compare:[NSIndexPath indexPathForRow:0 inSection:2]]==NSOrderedSame){//货架条形码扫描
//            [self gotoScanQRView:SCAN_SHELF];
        }
        else if([indexPath compare:[NSIndexPath indexPathForRow:1 inSection:2]]==NSOrderedSame){
//            [self showInputBox:INPUT_SHELF_CODE];
        }
        else if([indexPath compare:[NSIndexPath indexPathForRow:0 inSection:1]]==NSOrderedSame){
            [self showInputBox:INPUT_GOODS_SERIAL];
        }
        else if([indexPath compare:[NSIndexPath indexPathForRow:1 inSection:1]]==NSOrderedSame){
//            [self showInputBox:INPUT_GOODS_PRICE];
        }
        else if([indexPath compare:[NSIndexPath indexPathForRow:2 inSection:1]]==NSOrderedSame){
//            [self showInputBox:INPUT_GOODS_NUM];
        }
        [self hideDatePicker];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView setSeparatorInset:UIEdgeInsetsZero];
//    [tableView setLayoutMargins:UIEdgeInsetsZero];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 60;
    
    if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0,0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

-(void)searchGoodsWithCode:(NSString *)goods_code{
    //执行搜索
    if(goods_code&&goods_code.length>0){
        [self startLoadingActivityIndicator];
        [self.goods_model loadGoodsList:goods_code orGoodsName:nil];
    }
}

-(void)showDatePicker{
    if(_datePicker==nil){
        //创建一个UIPickView对象
        _datePicker = [[UIDatePicker alloc]init];
        //自定义位置
        _datePicker.frame = CGRectMake(0, HEIGHT_SCREEN+38, WIDTH_SCREEN, 200);
        //设置背景颜色
        _datePicker.backgroundColor = COLOR_BG_WHITE;
        //设置本地化支持的语言（在此是中文)
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        //显示方式是只显示年月日
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [_datePicker addTarget:self action:@selector(datePickerValueChange:) forControlEvents:UIControlEventValueChanged];
        
        
        UIBarButtonItem *fixedButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace  target: nil action: nil];
        UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                       style:UIBarButtonItemStylePlain target:self
                                                                      action:@selector(pickerDoneClicked:)];
        
       _keyboardDoneButtonView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, HEIGHT_SCREEN, WIDTH_SCREEN, 38)];
        _keyboardDoneButtonView.barStyle = UIBarStyleDefault;
        _keyboardDoneButtonView.translucent = YES;
        _keyboardDoneButtonView.barTintColor=COLOR_BG_TABLEVIEW;
        _keyboardDoneButtonView.tintColor = COLOR_DARKGRAY;
        [_keyboardDoneButtonView sizeToFit];
        [_keyboardDoneButtonView setItems:[NSArray arrayWithObjects:fixedButton,doneButton, nil]];
        
    }
    [self.view addSubview:_keyboardDoneButtonView];
    [self.view addSubview:_datePicker];
    
    [UIView animateWithDuration:0.35 animations:^{
        _datePicker.frame=CGRectMake(0, HEIGHT_SCREEN-200-64, WIDTH_SCREEN, 200);
        _keyboardDoneButtonView.frame=CGRectMake(0, HEIGHT_SCREEN-200-64-38, WIDTH_SCREEN, 38);
    }];
}

-(void)hideDatePicker{
    [UIView animateWithDuration:0.35 animations:^{
        _datePicker.frame=CGRectMake(0, HEIGHT_SCREEN, WIDTH_SCREEN, 200);
        _keyboardDoneButtonView.frame=CGRectMake(0, HEIGHT_SCREEN, WIDTH_SCREEN, 38);
    } completion:^(BOOL finished) {
        [_datePicker removeFromSuperview];
        [_keyboardDoneButtonView removeFromSuperview];
    }];
}

-(void)pickerDoneClicked:(id)sender{
    [self hideDatePicker];
}

- (void)datePickerValueChange:(UIDatePicker *)datePicker{
    //创建一个日期格式
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期的显示格式
    fmt.dateFormat = @"yyyy-MM-dd";
    //将日期转为指定格式显示
    NSString *dateStr = [fmt stringFromDate:datePicker.date];
    [[[itemArr objectAtIndex:1] objectAtIndex:3] setValue:dateStr forKey:@"item_value"];
    [self.tableView reloadData];
}


-(void)showInputBox:(GOODS_INPUT_MODEL)input_model{
    NSString *tip_title=@"";
    _current_input_model=input_model;
    
    if(input_model==INPUT_GOODS_CODE){
        tip_title=@"商品条形码";
    }
    else if(input_model==INPUT_SHELF_CODE){
        tip_title=@"货架条形码";
    }
    else if(input_model==INPUT_GOODS_SERIAL){
        tip_title=@"商品编号";
    }
    else if(input_model==INPUT_GOODS_PRICE){
        tip_title=@"商品进价";
    }
    else if(input_model==INPUT_GOODS_NUM){
        tip_title=@"商品数量";
    }
    
    if (_inputAlertView==nil) {
        _inputAlertView = [[UIAlertView alloc] initWithTitle:tip_title message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        _inputAlertView.delegate=self;
    }
    _inputAlertView.title=tip_title;
    [_inputAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    UITextField *nameField = [_inputAlertView textFieldAtIndex:0];
    nameField.delegate=self;
    nameField.placeholder =[NSString stringWithFormat:@"请输入%@",tip_title];
    
    if(input_model==INPUT_GOODS_CODE){
        nameField.keyboardType=UIKeyboardTypeNumberPad;
    }
    else if(input_model==INPUT_SHELF_CODE){
        nameField.keyboardType=UIKeyboardTypeDefault;
    }
    else if(input_model==INPUT_GOODS_SERIAL){
        nameField.keyboardType=UIKeyboardTypeNumberPad;
    }
    else if(input_model==INPUT_GOODS_PRICE){
        nameField.keyboardType=UIKeyboardTypeDecimalPad;
    }
    else if(input_model==INPUT_GOODS_NUM){
        nameField.keyboardType=UIKeyboardTypeNumberPad;
    }
    
    [_inputAlertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        UITextField *nameField = [alertView textFieldAtIndex:0];
        NSString *txt_value=[nameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if(_current_input_model==INPUT_GOODS_CODE){
            self.goods_code=txt_value;
            [self searchGoodsWithCode:txt_value];
        }
        else if(_current_input_model==INPUT_SHELF_CODE){
            self.shelf_code=txt_value;
        }
        else if(_current_input_model==INPUT_GOODS_SERIAL){
            [[[itemArr objectAtIndex:1] objectAtIndex:0] setValue:txt_value forKey:@"item_value"];
        }
        else if(_current_input_model==INPUT_GOODS_PRICE){
            [[[itemArr objectAtIndex:1] objectAtIndex:1] setValue:[NSString stringWithFormat:@"$%.2f",round([txt_value floatValue]*100)/100] forKey:@"item_value"];
        }
        else if(_current_input_model==INPUT_GOODS_NUM){
            if([txt_value intValue]>0){
                [[[itemArr objectAtIndex:1] objectAtIndex:2] setValue:[NSString stringWithFormat:@"%d",[txt_value intValue]] forKey:@"item_value"];
            }
            else{
                [self showToastWithText:@"商品数量需要大于0"];
            }
        }
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
    if(_current_input_model==INPUT_GOODS_CODE||_current_input_model==INPUT_SHELF_CODE){
        if([textField.text length] >= 18){
            textField.text = [[textField.text substringToIndex:18] uppercaseString];
            return NO;
        }
        else{
            textField.text=[textField.text uppercaseString];
        }
    }
    else{
        if([textField.text length] >= 6){
            textField.text = [textField.text substringToIndex:6];
            return NO;
        }
    }
    
    return YES;
}

-(void)nextGoods:(UIButton *)sender{
    if(sender.tag==3001){//保存并返回
        self.save_model=SAVE_THEN_BACK;
    }
    else{//保存并继续
        self.save_model=SAVE_THEN_CONTINUE;
    }
    
    [self saveRukuGoods];
}

-(BOOL)checkEntity:(RukuGoodsEntity*)entity{
    if(entity){
        if(entity.batch_id==nil||entity.batch_id.length<=0){
            [self showToastWithText:@"缺少入库批次信息"];
            return NO;
        }
        else if(entity.goods_code==nil||entity.goods_code.length<=0){
            [self showToastWithText:@"缺少商品条形码"];
            return NO;
        }
        else if(entity.shelves_code==nil||entity.shelves_code.length<=0){
            [self showToastWithText:@"缺少货架号"];
            return NO;
        }
        else if(entity.number==nil||entity.number.length<=0||[entity.number intValue]<=0){
            [self showToastWithText:@"无有效的商品数量"];
            return NO;
        }
        else if(entity.cost==nil||entity.cost.length<=0||[entity.cost intValue]<0){
            [self showToastWithText:@"无有效的商品进价"];
            return NO;
        }
        else if(entity.expired_date==nil||entity.expired_date.length<=0){
            [self showToastWithText:@"缺少保质期信息"];
            return NO;
        }
    }
    else{
        [self showToastWithText:@"无效信息"];
        return NO;
    }
    return YES;
}

-(void)saveRukuGoods{
    RukuGoodsEntity *entity=[[RukuGoodsEntity alloc] init];
    entity.batch_id=self.batch_id;
    entity.goods_id=self.goods_id==nil?@"0":self.goods_id;
    entity.goods_code=self.goods_code;
    if([[self.shelf_code stringByReplacingOccurrencesOfString:@" " withString:@""] length]<=0){
        self.shelf_code=@"A1.1.1.1";
    }
    else{
        entity.shelves_code=[self.shelf_code uppercaseString];
    }
    entity.expired_date=[[[itemArr objectAtIndex:1] objectAtIndex:3] valueForKey:@"item_value"];
    entity.no=[[[itemArr objectAtIndex:1] objectAtIndex:0] valueForKey:@"item_value"];
    if([[[[itemArr objectAtIndex:1] objectAtIndex:2] valueForKey:@"item_value"] intValue]<=0){
        entity.number=@"1";
    }
    else{
         entity.number=[[[itemArr objectAtIndex:1] objectAtIndex:2] valueForKey:@"item_value"];
    }
    
    if([[[[[itemArr objectAtIndex:1] objectAtIndex:1] valueForKey:@"item_value"] stringByReplacingOccurrencesOfString:@"$" withString:@""] floatValue]<=0){
        entity.cost=@"0.01";
    }
    else{
        entity.cost=[[[[itemArr objectAtIndex:1] objectAtIndex:1] valueForKey:@"item_value"] stringByReplacingOccurrencesOfString:@"$" withString:@""];
    }

    if([self checkEntity:entity]){
        [self startLoadingActivityIndicator];
        [self.model addRukuGoods:entity];
    }
}

-(void)gotoScanQRView:(SCAN_MODEL)scan_model{
    QRCodeViewController *qvc=[[QRCodeViewController alloc] init];
    qvc.scan_model=scan_model;
    qvc.pass_delegate=self;
    [self.navigationController pushViewController:qvc animated:YES];
}

-(void)passObject:(id)obj{
    if([obj class]==[GoodsEntity class]){
        self.scan_entity=(GoodsEntity *)obj;
        self.goods_id=self.scan_entity.goods_id;
        self.goods_code=self.scan_entity.goods_code;
        [self.tableView reloadData];
    }
    else{
        if([[obj objectForKey:@"scan_model"] intValue]==SCAN_GOODS){//商品条形码
            self.goods_code=[obj objectForKey:@"code"];
            [self searchGoodsWithCode:self.goods_code];
        }
        else if([[obj objectForKey:@"scan_model"] intValue]==SCAN_SHELF){//货架条形码
            NSArray *array = [[obj objectForKey:@"code"] componentsSeparatedByString:@"."];
            
            if([[obj objectForKey:@"code"] length]>0&&array.count==4){
                self.shelf_code=[obj objectForKey:@"code"];
            }
            else{
                [self showToastWithText:@"无法识别的货架条码"];
            }
        }
        [self.tableView reloadData];
    }
}

-(void)gotoGoodsSearchView{
    GoodsSearchViewController *gvc=[[GoodsSearchViewController alloc] init];
    gvc.pass_delegate=self;
    [self.navigationController pushViewController:gvc animated:YES];
}

-(void)gotoGoodsShelfView{
    if(self.scan_entity){
        GoodsShelfViewController *gvc=[[GoodsShelfViewController alloc] init];
        gvc.goods_entity=self.scan_entity;
        gvc.shelf_list_model=SHELF_LIST_MODEL_VIEW;
        [self.navigationController pushViewController:gvc animated:YES];
    }
}


-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}


-(StockModel *)model{
    if(!_model){
        _model=[[StockModel alloc] init];
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
