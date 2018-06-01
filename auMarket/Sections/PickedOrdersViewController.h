//
//  PickViewController.h
//  auMarket
//
//  Created by 吴绪伟 on 2018/1/4.
//  Copyright © 2018年 daao. All rights reserved.
//

#import "SPBaseViewController.h"
#import "PickGoodsViewController.h"
#import "PickOrderCell.h"
#import "PickModel.h"
#import "QRCodeViewController.h"
#import <MJRefresh.h>

@interface PickedOrdersViewController : SPBaseViewController
{
}


@property(nonatomic,retain) PickModel *model;
@property(nonatomic,retain) OrderItemEntity *bind_order_entity;
@end
