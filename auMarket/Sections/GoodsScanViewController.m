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
   _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(40, 100, WIDTH_SCREEN-80, 40)];
   _searchBar.placeholder = @"扫描商品条形码";
   _searchBar.delegate = self;
   _searchBar.tintColor = COLOR_WHITE;
   _searchBar.autocorrectionType=UITextAutocorrectionTypeNo;
   _searchBar.autocapitalizationType=UITextAutocapitalizationTypeNone;
   _searchBar.keyboardType=UIKeyboardTypeDefault;
   _searchBar.backgroundColor=RGBCOLOR(246, 246, 246);
   
   UITextField *searchField;
//    if(@available(iOS 11.0, *)) {
//      [[_searchBar.heightAnchor constraintEqualToConstant:44] setActive:YES];
//    }
    
    if (@available(iOS 13.0, *)) {
        searchField=_searchBar.searchTextField;
        searchField.backgroundColor=RGBACOLOR(40, 40, 40,0.1);
        searchField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"扫描商品条形码" attributes:@{NSForegroundColorAttributeName: COLOR_WHITE}];
        searchField.leftView.tintColor=COLOR_LIGHTGRAY;
    }
    else{
        searchField = [_searchBar valueForKey:@"_searchField"];
        [searchField setValue:COLOR_WHITE forKeyPath:@"_placeholderLabel.textColor"];
        //[_searchBar setImage:[UIImage imageNamed:@"search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    }
    
    // 输入文本颜色
    searchField.textColor = COLOR_FONT_BLACK;
    searchField.font=FONT_SIZE_MIDDLE;

    //设置searchbar的背景颜色
    float version = [[[ UIDevice currentDevice ] systemVersion ] floatValue ];
    if ([_searchBar respondsToSelector : @selector (barTintColor)]) {
        float iosversion7_1 = 7.1 ;
        if (version >= iosversion7_1)
        {
            //iOS7.1
            [[[[_searchBar.subviews objectAtIndex:0 ] subviews ] objectAtIndex:0 ] removeFromSuperview ];
            [_searchBar setBackgroundColor:COLOR_CLEAR];
            _searchBar.layer.contents = nil;
        }
        else
        {
            //iOS7.0
            [_searchBar setBarTintColor:[ UIColor clearColor]];
            [_searchBar setBackgroundColor:COLOR_CLEAR];
        }
    }
    else
    {
        //iOS7.0 以下
        [[_searchBar. subviews objectAtIndex : 0 ] removeFromSuperview ];
        [_searchBar setBackgroundColor :COLOR_CLEAR];
    }
    //设置textfield的背景颜色
    for (UIView *view in [_searchBar subviews]) {
        if ([view isKindOfClass:[UITextField class]]) {
            view.backgroundColor = RGBACOLOR(240, 240, 240,0.1);
            break;
        }
        if ([view isKindOfClass:NSClassFromString(@"UIView")]) {
            for (UIView *subView in view.subviews) {
                if (@available(iOS 13.0, *)) {
                    break;
                }
                else {
                    subView.backgroundColor = RGBACOLOR(40, 40, 40,0.1);
                }
                break;
            }
        }
    }
    [self.view addSubview:_searchBar];
}


#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
    //执行搜索
    [self startLoadingActivityIndicator];
    //[self.model loadGoodsList:nil orGoodsName:[_searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    _searchBar.text=@"";
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    long n=[_searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length;
    if(n>40){
        searchBar.text = [searchBar.text substringToIndex:[searchBar.text length]-1];
    }
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    keyboardDoneButtonView.barStyle = UIBarStyleDefault;
    keyboardDoneButtonView.translucent = YES;
    keyboardDoneButtonView.tintColor = RGBCOLOR(165, 165, 165);
    [keyboardDoneButtonView sizeToFit];
    
    UIBarButtonItem *fixedButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                                                                  target: nil
                                                                                  action: nil];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(pickerDoneClicked:)];
    doneButton.tintColor=RGBCOLOR(99, 99, 99);
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:fixedButton,doneButton, nil]];
    //searchBar.inputAccessoryView = keyboardDoneButtonView;
}

-(void)pickerDoneClicked:(id)sender{
    [_searchBar resignFirstResponder];
}


/* 点击背景时关闭键盘 **/
-(void)handleBackgroundTap:(UITapGestureRecognizer *)sender{
    [self resignAllResponder];
}

- (void)resignAllResponder
{
    [_searchBar resignFirstResponder];
}

- (void)disMissSearch {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [super viewWillAppear:YES];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
       [_searchBar becomeFirstResponder];
    });
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   
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
