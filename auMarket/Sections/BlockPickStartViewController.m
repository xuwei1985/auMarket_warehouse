//
//  goodsBindViewController.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/8.
//  Copyright © 2016年 daao. All rights reserved.
//
#import "BlockPickStartViewController.h"

@interface BlockPickStartViewController ()

@end

@implementation BlockPickStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    [self initData];
}

-(void)initUI{
    [self setNavigation];
    [self createViews];
}

-(void)initData{
    
}

-(void)setNavigation{
    self.title=@"分区拣货";
    
    UIBarButtonItem *right_Item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"jhz"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(gotoBlockPickGoodsView)];
    
    self.navigationItem.rightBarButtonItem=right_Item;
}

-(void)createViews{
    beginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [beginBtn setTitle:@"开始拣货" forState:UIControlStateNormal];
    [beginBtn setTitleColor:COLOR_WHITE forState:UIControlStateSelected];
    [beginBtn setBackgroundColor:COLOR_MAIN];
    beginBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    beginBtn.tintColor=COLOR_WHITE;
    beginBtn.titleLabel.font=FONT_SIZE_BIG;
    [beginBtn addTarget:self action:@selector(startPick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:beginBtn];
    
     @weakify(self);
    [beginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(48);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    cartView=[[UIView alloc] init];
    cartView.backgroundColor=COLOR_WHITE;
    [self.view addSubview:cartView];
    [cartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(175);
        make.top.mas_equalTo(0);
    }];
    
    blockView=[[UIView alloc] init];
    blockView.backgroundColor=COLOR_WHITE;
    [self.view addSubview:blockView];
    [blockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(175);
        make.top.mas_equalTo(cartView.mas_bottom).offset(1);
    }];
    
    UILabel *lbl_cart_title=[[UILabel alloc] init];
    lbl_cart_title.textAlignment=NSTextAlignmentCenter;
    lbl_cart_title.textColor=COLOR_DARKGRAY;
    lbl_cart_title.font=FONT_SIZE_MIDDLE;
    lbl_cart_title.text=@"当前拣货车";
    [cartView addSubview:lbl_cart_title];
    
    [lbl_cart_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200,25));
        make.top.mas_equalTo(20);
    }];
    
    lblCartNum=[[UILabel alloc] init];
    lblCartNum.textAlignment=NSTextAlignmentCenter;
    lblCartNum.textColor=COLOR_MAIN;
    lblCartNum.font=[UIFont boldSystemFontOfSize:22];
    lblCartNum.text=@"--";
    [cartView addSubview:lblCartNum];
    
    [lblCartNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200,25));
        make.top.mas_equalTo(lbl_cart_title.mas_bottom).offset(10);
    }];
    
    UIButton *scanCartBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [scanCartBtn setTitle:@"扫描拣货车" forState:UIControlStateNormal];
    [scanCartBtn setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
    [scanCartBtn setTitleColor:COLOR_GRAY forState:UIControlStateHighlighted];
    [scanCartBtn setImage:[UIImage imageNamed:@"bs_1"] forState:UIControlStateNormal];
    [scanCartBtn setBackgroundColor:COLOR_MAIN];
    scanCartBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    scanCartBtn.tintColor=COLOR_WHITE;
    scanCartBtn.titleLabel.font=FONT_SIZE_MIDDLE_BLOD;
    [scanCartBtn.layer setCornerRadius:24.0f];
    scanCartBtn.clipsToBounds=YES;
    scanCartBtn.tag=1001;
    [scanCartBtn addTarget:self action:@selector(gotoScanQRView:) forControlEvents:UIControlEventTouchUpInside];
    [scanCartBtn setTitleEdgeInsets:UIEdgeInsetsMake(15, 0, 15, 0)];
    [scanCartBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 5, 10, 35)];   //40 * 40
    [cartView addSubview:scanCartBtn];
    
    [scanCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WIDTH_SCREEN*0.20);
        make.right.mas_equalTo(WIDTH_SCREEN*-0.20);
        make.height.mas_equalTo(48);
        make.top.mas_equalTo(lblCartNum.mas_bottom).offset(25);
    }];
    
    UILabel *lbl_block_title=[[UILabel alloc] init];
    lbl_block_title.textAlignment=NSTextAlignmentCenter;
    lbl_block_title.textColor=COLOR_DARKGRAY;
    lbl_block_title.font=FONT_SIZE_MIDDLE;
    lbl_block_title.text=@"当前拣货区域";
    [blockView addSubview:lbl_block_title];
    
    [lbl_block_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200,25));
        make.top.mas_equalTo(20);
    }];
    
    lblBlockName=[[UILabel alloc] init];
    lblBlockName.textAlignment=NSTextAlignmentCenter;
    lblBlockName.textColor=[Common hexColor:@"#4187F2"];
    lblBlockName.font=[UIFont boldSystemFontOfSize:22];
    lblBlockName.text=@"--";
    [blockView addSubview:lblBlockName];
    
    [lblBlockName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200,25));
        make.top.mas_equalTo(lbl_block_title.mas_bottom).offset(10);
    }];
    
    UIButton *scanBlockBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [scanBlockBtn setTitle:@"扫描拣货区域" forState:UIControlStateNormal];
    [scanBlockBtn setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
    [scanBlockBtn setTitleColor:COLOR_GRAY forState:UIControlStateHighlighted];
    [scanBlockBtn setImage:[UIImage imageNamed:@"bs_2"] forState:UIControlStateNormal];
    [scanBlockBtn setBackgroundColor:[Common hexColor:@"#4187F2"]];
    scanBlockBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    scanBlockBtn.tintColor=COLOR_WHITE;
    scanBlockBtn.titleLabel.font=FONT_SIZE_MIDDLE_BLOD;
    [scanBlockBtn.layer setCornerRadius:24.0f];
    scanBlockBtn.clipsToBounds=YES;
    scanBlockBtn.tag=1002;
    [scanBlockBtn addTarget:self action:@selector(gotoScanQRView:) forControlEvents:UIControlEventTouchUpInside];
    [scanBlockBtn setTitleEdgeInsets:UIEdgeInsetsMake(15, 0, 15, 0)];
    [scanBlockBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 5, 10, 35)];   //40 * 40
    [blockView addSubview:scanBlockBtn];
    
    [scanBlockBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WIDTH_SCREEN*0.20);
        make.right.mas_equalTo(WIDTH_SCREEN*-0.20);
        make.height.mas_equalTo(48);
        make.top.mas_equalTo(lblBlockName.mas_bottom).offset(25);
    }];
}

-(void)startPick:(id)sender{
    scan_cart_num=@"3";
    scan_block_id=@"1";
    if([scan_cart_num length]>0&&[scan_block_id length]>0){
        [self loadBlockPickGoodsList];
    }else{
         [self showToastWithText:@"请先扫描对应条码"];
    }
}

-(void)gotoScanQRView:(UIButton *)sender{
    QRCodeViewController *qvc=[[QRCodeViewController alloc] init];
    if(sender.tag==1001){
        qvc.scan_model=SCAN_PICK_CART;
    }else{
        qvc.scan_model=SCAN_SHELF_BLOCK;
    }
    
    qvc.pass_delegate=self;
    [self.navigationController pushViewController:qvc animated:YES];
}

-(void)gotoBlockPickGoodsView{
    BlockPickGoodsViewController *bvc=[[BlockPickGoodsViewController alloc] init];
    [self.navigationController pushViewController:bvc animated:YES];
}

-(void)passObject:(id)obj{
    if([[obj objectForKey:@"scan_model"] intValue]==SCAN_SHELF_BLOCK){//货架区块条形码
        //提交绑定信息到接口
        NSArray *lab = [[obj objectForKey:@"code"] componentsSeparatedByString:@"-"];
        if(lab.count==3){
            scan_block_id=[lab objectAtIndex:1];
            lblBlockName.text=[NSString stringWithFormat:@"%@区",[lab objectAtIndex:2]];
        }
        else{
            [self showToastWithText:@"无法识别的货架区块条码"];
        }
    }
    else if([[obj objectForKey:@"scan_model"] intValue]==SCAN_PICK_CART){//拣货车条形码
        NSRange range = [[obj objectForKey:@"code"] rangeOfString:@"PC-"];
        if([[obj objectForKey:@"code"] length]>0&&range.location != NSNotFound){
            scan_cart_num= [[obj objectForKey:@"code"] stringByReplacingOccurrencesOfString:@"PC-" withString:@""];
            lblCartNum.text=[NSString stringWithFormat:@"%@号车",scan_cart_num];
        }
        else{
            [self showToastWithText:@"无法识别的拣货车条形码"];
        }
    }
    else{
        [self showToastWithText:@"未知扫码结果"];
    }
}

//请求订单下的要拣货的商品
-(void)loadBlockPickGoodsList{
    [self startLoadingActivityIndicator];
    [self.model startBlockPick:scan_block_id andCart:scan_cart_num];
}


-(void)onResponse:(SPBaseModel *)model isSuccess:(BOOL)isSuccess{
    [self stopLoadingActivityIndicator];
    
    if(model==self.model&&self.model.requestTag==1016){
        if(isSuccess){
            [self showSuccesWithText:@"任务生成成功，请开始捡货"];
            scan_block_id=@"";
            scan_cart_num=@"";
            lblBlockName.text=@"--";
            lblCartNum.text=@"--";
            [self gotoBlockPickGoodsView];
        }
    }
}


-(PickModel *)model{
    if(!_model){
        _model=[[PickModel alloc] init];
        _model.delegate=self;
    }
    return _model;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
