//
//  HomeViewController.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/8.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "SPBaseViewController.h"
#import "GoodsBindViewController.h"
#import "StockModel.h"
#import "BatchCell.h"
#import <MJRefresh.h>

@interface BatchViewController : SPBaseViewController
{
    
}
@property(nonatomic,retain) StockModel *model;
@end
