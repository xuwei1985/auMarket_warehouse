//
//  SearchViewController.h
//  cute
//
//  Created by vivi on 15/3/17.
//  Copyright (c) 2015年 seegame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsListModel.h"
#import "GoodsListItemCell.h"

@interface GoodsSearchViewController : SPBaseViewController<UISearchBarDelegate>
{
    UISearchBar *_searchBar;
    NSString *keyword;
    UIView *titleView;
}
@property(nonatomic,assign) NSObject<PassValueDelegate> *pass_delegate;
@property(nonatomic,retain) GoodsListModel *model;
@end
