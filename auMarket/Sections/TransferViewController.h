//
//  TransferViewController.h
//  auMarket
//
//  Created by 吴绪伟 on 2018/5/19.
//  Copyright © 2018 daao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockCell.h"
#import "QRCodeViewController.h"
#import "GoodsSearchViewController.h"
#import "GoodsShelfViewController.h"

@interface TransferViewController : SPBaseViewController<PassValueDelegate>
{
    NSMutableArray *itemArr;
}

@property(nonatomic,retain) NSString *goods_code;

@end
