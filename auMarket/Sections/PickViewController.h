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
#import "RegionModel.h"
#import "QRCodeViewController.h"
#import <MJRefresh.h>
#import "PickedOrdersViewController.h"

@interface PickViewController : SPBaseViewController<PassValueDelegate>
{
    UIView *_summaryView;
    UIView *_summaryView_bottom;
    UIButton *_sumBtn;
    UIButton *_selectAllBtn;
    NSString *order_ids;
    Boolean isPushToPickGoodsView;
    SPBaseTableView *regionsView;
    UIButton *btn_region;
    NSMutableArray<RegionBlockEntity *> *region_data;
    int region_block_id;
    Boolean isCreating;
}


@property(nonatomic,retain) PickModel *model;
@property(nonatomic,retain) RegionModel *region_model;
@property(nonatomic,retain) OrderItemEntity *bind_order_entity;
@end
