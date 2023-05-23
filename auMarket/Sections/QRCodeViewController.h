//
//  LWQRCodeViewController.h
//  LWProjectFramework
//
//  Created by bhczmacmini on 16/12/28.
//  Copyright © 2016年 LW. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "StockModel.h"
typedef void(^ScanResultBlock)(NSString *scanText);

@interface QRCodeViewController : SPBaseViewController
@property(nonatomic,assign) NSObject<PassValueDelegate> *pass_delegate;
@property(nonatomic,assign) SCAN_MODEL scan_model;
@end
