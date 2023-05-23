//
//  SearchViewController.h
//  cute
//
//  Created by vivi on 15/3/17.
//  Copyright (c) 2015年 seegame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockModel.h"

@interface GoodsScanViewController : SPBaseViewController<UISearchBarDelegate>
{
    UISearchBar *_searchBar;
    NSString *keyword;
    UIView *titleView;
}
typedef void(^ScanResultBlock)(NSString *scanText);

@property(nonatomic,assign) NSObject<PassValueDelegate> *pass_delegate;
@property(nonatomic,assign) SCAN_MODEL scan_model;
@end
