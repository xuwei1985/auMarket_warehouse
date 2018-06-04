//
//  TransferShelfCell.h
//  auMarket
//
//  Created by 吴绪伟 on 2018/5/21.
//  Copyright © 2018 daao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransferGoodsEntity.h"
typedef void(^SelStackGoodsBlock)(NSString *goods_id,int action);
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
@property(nonatomic,retain) TransferGoodsItemEntity *entity;
@property (nonatomic, copy) SelStackGoodsBlock selStackGoodsBlock;
@property (nonatomic,assign) int cell_model;//0:待转移 1:已转移
-(void)selStackGoods:(SelStackGoodsBlock)block;
-(void)toggleGoodsSel;
@end
