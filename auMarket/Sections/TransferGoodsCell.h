//
//  TransferShelfCell.h
//  auMarket
//
//  Created by 吴绪伟 on 2018/5/21.
//  Copyright © 2018 daao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShelfEntity.h"
typedef void(^AddStackBlock)(NSString *order_id);
@interface TransferGoodsCell : UITableViewCell
{
    UIImageView *img_goods;
    UIButton *btn_select;
    UILabel *lbl_goods_num;
    UILabel *lbl_shelf_old;
    UILabel *lbl_shelf_new;
    UILabel *lbl_goods_name_value;
    UILabel *lbl_goods_num_value;
    UILabel *lbl_shelf_old_value;
    UILabel *lbl_shelf_new_value;
}
@property(nonatomic,retain) ShelfItemEntity *entity;
@property (nonatomic, copy) AddStackBlock addStackBlock;
-(void)addStack:(AddStackBlock)block;
@end
