//
//  PickOrderCell.h
//  auMarket
//
//  Created by 吴绪伟 on 2018/5/21.
//  Copyright © 2018 daao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderEntity.h"

typedef void(^SelOrderBlock)(NSString *order_id,int action);

@interface PickOrderCell : UITableViewCell
{
    UIButton *btn_select;
    UILabel *lbl_order_sn;
    UILabel *lbl_order_goods_num;
    UILabel *lbl_order_region;
    UILabel *lbl_order_price;
    UILabel *lbl_bind_tip;
    UILabel *lbl_bind_mark;
    UILabel *lbl_done_time;
    
    UILabel *lbl_order_sn_value;
    UILabel *lbl_order_goods_num_value;
    UILabel *lbl_order_region_value;
    UILabel *lbl_order_price_value;
    UILabel *lbl_done_time_value;
    UIButton *btn_type_freeze;
    UIButton *btn_type_zero;
    UIButton *btn_type_box;
}

@property(nonatomic,retain) OrderItemEntity *entity;
@property (nonatomic, copy) SelOrderBlock selOrderBlock;
@property (nonatomic, assign) int list_model;//0:待拣货订单 1：已拣货列表

-(void)selOrderId:(SelOrderBlock)block;
-(void)toggleOrderSel;
@end
