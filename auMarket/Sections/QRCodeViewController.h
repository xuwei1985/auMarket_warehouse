//
//  LWQRCodeViewController.h
//  LWProjectFramework
//
//  Created by bhczmacmini on 16/12/28.
//  Copyright © 2016年 LW. All rights reserved.
//

//扫描模式
typedef enum : NSUInteger {
    SCAN_GOODS=0,//商品条形码
    SCAN_SHELF=1//货架条形码
} SCAN_MODEL;

#import <UIKit/UIKit.h>
typedef void(^ScanResultBlock)(NSString *scanText);

@interface QRCodeViewController : SPBaseViewController
@property(nonatomic,assign) NSObject<PassValueDelegate> *pass_delegate;
@property(nonatomic,assign) SCAN_MODEL scan_model;
@end
