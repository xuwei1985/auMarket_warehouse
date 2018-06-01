//
//  PickOrderCell.h
//  auMarket
//
//  Created by 吴绪伟 on 2018/5/21.
//  Copyright © 2018 daao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShelfEntity.h"
typedef void(^AddStackBlock)(NSString *ruku_id,NSString *number);
@interface GoodsShelfCell : UITableViewCell
{
    UIButton *btn_select;
    UILabel *lbl_order_sn;
    UILabel *lbl_order_goods_num;
    UILabel *lbl_order_region;
    UILabel *lbl_order_price;
    UILabel *lbl_bind_tip;
    UILabel *lbl_bind_mark;
    
    UILabel *lbl_order_sn_value;
    UILabel *lbl_order_goods_num_value;
    UILabel *lbl_order_region_value;
    UILabel *lbl_order_price_value;
}
@property(nonatomic,retain) ShelfItemEntity *entity;
@property (nonatomic, copy) AddStackBlock addStackBlock;
-(void)addStack:(AddStackBlock)block;
@end
