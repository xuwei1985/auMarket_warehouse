//
//  SearchViewController.h
//  cute
//
//  Created by vivi on 15/3/17.
//  Copyright (c) 2015年 seegame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockModel.h"

@interface GoodsScanViewController : SPBaseViewController<UITextFieldDelegate>
{
    UITextField *goodsCodeField;
}
typedef void(^ScanResultBlock)(NSString *scanText);

@property(nonatomic,assign) NSObject<PassValueDelegate> *pass_delegate;
@property(nonatomic,assign) SCAN_MODEL scan_model;
@end
