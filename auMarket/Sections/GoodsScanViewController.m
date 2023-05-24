//
//  SearchViewController.m
//  cute
//
//  Created by vivi on 15/3/17.
//  Copyright (c) 2015年 seegame. All rights reserved.
//
#import "GoodsScanViewController.h"

@interface GoodsScanViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UILabel *noticeLabel;
    UIButton *cancelBtn;
}
@end

@implementation GoodsScanViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        [self.view setBackgroundColor:COLOR_BG_WHITE];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleBackgroundTap:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
    
    [self initUI];
}


- (void)initUI
{
    [self createSearchBar];
    [self setNavigation];

}

-(void)setNavigation{
    self.navigationItem.title=@"扫描商品条码";
}

- (void)createSearchBar
{
    goodsCodeField = [[UITextField alloc] initWithFrame:CGRectMake(40, 100, WIDTH_SCREEN-80, 48)];
    goodsCodeField.delegate=self;
    goodsCodeField.placeholder =@"扫描商品条形码";
    goodsCodeField.keyboardType=UIKeyboardTypeDefault;
    goodsCodeField.tintColor = COLOR_FONT_BLACK;
    goodsCodeField.autocorrectionType=UITextAutocorrectionTypeNo;
    goodsCodeField.autocapitalizationType=UITextAutocapitalizationTypeNone;
    goodsCodeField.backgroundColor=RGBCOLOR(246, 246, 246);
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 48)];
    goodsCodeField.leftView = paddingView;
    goodsCodeField.rightView = paddingView;
    goodsCodeField.leftViewMode = UITextFieldViewModeAlways;
    goodsCodeField.rightViewMode = UITextFieldViewModeAlways;
    goodsCodeField.layer.cornerRadius=6;
    goodsCodeField.clipsToBounds=true;
    goodsCodeField.font=FONT_SIZE_BIG;
    goodsCodeField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: goodsCodeField];
}


/* 点击背景时关闭键盘 **/
-(void)handleBackgroundTap:(UITapGestureRecognizer *)sender{
    [self resignAllResponder];
}

- (void)resignAllResponder
{
    [goodsCodeField resignFirstResponder];
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)disMissSearch {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
       [goodsCodeField becomeFirstResponder];
    });
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goBack{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)handlerScanResult:(NSString *)stringValue{
    if(self.scan_model==SCAN_GOODS){
        if(stringValue!=nil&&stringValue.length==13&&[stringValue hasPrefix:@"0"]){
            stringValue=[stringValue substringFromIndex:1];
        }
    }
    if([self.pass_delegate respondsToSelector:@selector(passObject:)]){
        [self.pass_delegate passObject:[NSDictionary dictionaryWithObjectsAndKeys:stringValue,@"code",[NSString stringWithFormat:@"%lu",(unsigned long)self.scan_model],@"scan_model", nil]];
    }
    [self goBack];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self handlerScanResult:[textField.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    [textField resignFirstResponder];
    textField.text=@"";
    return YES;
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
    if([textField.text length] >= 40){
        textField.text = [textField.text substringToIndex:40];
        return NO;
    }
    
    return YES;
}

@end
