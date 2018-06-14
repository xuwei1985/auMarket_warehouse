//
//  PickOrderCell.h
//  auMarket
//
//  Created by 吴绪伟 on 2018/5/21.
//  Copyright © 2018 daao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShelfEntity.h"

//来源模式
typedef enum : NSUInteger {
    SHELF_LIST_MODEL_SELF=0,//来源于自己，独立模式
    SHELF_LIST_MODEL_PICK=1,//来自于商品拣货
    SHELF_LIST_MODEL_VIEW=2//普通的浏览模式
} SHELF_LIST_MODEL;

typedef void(^AddStackBlock)(ShelfItemEntity *entity);
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
@property(nonatomic,assign) SHELF_LIST_MODEL shelf_list_model;
@property (nonatomic, copy) AddStackBlock addStackBlock;
-(void)addStack:(AddStackBlock)block;
@end
