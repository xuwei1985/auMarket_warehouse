//
//  LWQRCodeViewController.h
//  LWProjectFramework
//
//  Created by bhczmacmini on 16/12/28.
//  Copyright © 2016年 LW. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ScanResultBlock)(NSString *scanText);

@interface QRCodeViewController : UIViewController
@property(nonatomic,assign) NSObject<PassValueDelegate> *pass_delegate;
@end
