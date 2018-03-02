//
//  StockViewController.h
//  auMarket
//
//  Created by 吴绪伟 on 2018/1/10.
//  Copyright © 2018年 daao. All rights reserved.
//

#import "SPBaseViewController.h"
#import "StockModel.h"
#import "StockCell.h"

@interface StockViewController : SPBaseViewController{
    NSMutableArray *itemArr;
}
@property(nonatomic,retain) StockModel *model;
@end
