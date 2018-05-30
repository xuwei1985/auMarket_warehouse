//
//  SearchViewController.m
//  cute
//
//  Created by vivi on 15/3/17.
//  Copyright (c) 2015年 seegame. All rights reserved.
//
#define Pull_Record_Num 50
#import "GoodsSearchViewController.h"

@interface GoodsSearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{

    UILabel *noticeLabel;
    UIButton *cancelBtn;
}
@end

@implementation GoodsSearchViewController
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
    
    [self initData];
    [self initUI];
}

- (void)initData
{
    
}

- (void)initUI
{
    [self createSearchBar];
    [self setNavigation];
    [self setUpTableView];

}

-(void)setNavigation{
    self.navigationItem.titleView=_searchBar;
    
    cancelBtn=[[UIButton alloc] initWithFrame:CGRectMake(WIDTH_SCREEN-40, 4, 40, 32)];
    [cancelBtn addTarget:self action:@selector(disMissSearch) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
    [cancelBtn setTitleColor:COLOR_WHITE forState:UIControlStateHighlighted];
    cancelBtn.titleLabel.font=FONT_SIZE_MIDDLE;
    cancelBtn.titleLabel.textAlignment=NSTextAlignmentCenter;

    UIBarButtonItem *right_Item_cart = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.navigationItem.rightBarButtonItem=right_Item_cart;
}


- (void)createSearchBar
{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN-54, 40)];
    _searchBar.placeholder = @"搜索商品关键词，以空格分开";
    _searchBar.delegate = self;
    _searchBar.tintColor = COLOR_WHITE;
    _searchBar.autocorrectionType=UITextAutocorrectionTypeNo;
    _searchBar.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _searchBar.keyboardType=UIKeyboardTypeDefault;
    _searchBar.hidden=NO;
    _searchBar.backgroundColor=RGBCOLOR(246, 246, 246);
    if(@available(iOS 11.0, *)) {
        [[_searchBar.heightAnchor constraintEqualToConstant:44] setActive:YES];
    }
    
    UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
    // 输入文本颜色
    searchField.textColor = COLOR_WHITE;
    searchField.font=FONT_SIZE_MIDDLE;
    // 默认文本颜色
    [searchField setValue:COLOR_WHITE forKeyPath:@"_placeholderLabel.textColor"];
    
    //设置searchbar的背景颜色
    float version = [[[ UIDevice currentDevice ] systemVersion ] floatValue ];
    if ([_searchBar respondsToSelector : @selector (barTintColor)]) {
        float iosversion7_1 = 7.1 ;
        if (version >= iosversion7_1)
        {
            //iOS7.1
            [[[[_searchBar.subviews objectAtIndex:0 ] subviews ] objectAtIndex:0 ] removeFromSuperview ];
            [_searchBar setBackgroundColor:COLOR_CLEAR];
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
                subView.backgroundColor = RGBACOLOR(40, 40, 40,0.1);
                break;
            }
        }
    }
    [_searchBar setImage:[UIImage imageNamed:@"search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
}


#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
    //执行搜索
    [self startLoadingActivityIndicator];
    [self.model loadGoodsList:nil orGoodsName:[_searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
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

-(void)selectAllOrders:(UIButton *)sender{
    
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
    NSString *identifier=@"goodsCellIdentifier";
    GoodsListItemCell *cell = [tv dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[GoodsListItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.showsReorderControl = NO;
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.backgroundColor=COLOR_BG_TABLEVIEWCELL;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.entity=[self.model.entity.list objectAtIndex:indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 108;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tv deselectRowAtIndexPath:[tv indexPathForSelectedRow] animated:YES];
    
    [self disMissSearch];
    if([self.pass_delegate respondsToSelector:@selector(passObject:)]){
        [self.pass_delegate passObject:[self.model.entity.list objectAtIndex:indexPath.row]];
    }
}


-(void)onResponse:(SPBaseModel *)model isSuccess:(BOOL)isSuccess{
    [self stopLoadingActivityIndicator];
    
    if(model==self.model&&model.requestTag==1001){//获取列表
        if(isSuccess){
            [self.tableView reloadData];
        }
        else{
            
        }
    }
}

-(GoodsListModel *)model{
    if(!_model){
        _model=[[GoodsListModel alloc] init];
        _model.delegate=self;
    }
    return _model;
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
