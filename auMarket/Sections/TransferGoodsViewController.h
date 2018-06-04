//
//  goodsBindViewController.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/8.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "SPBaseViewController.h"
#import "StockViewController.h"
#import "TransferGoodsCell.h"
#import "TransferModel.h"

@interface TransferGoodsViewController : SPBaseViewController<UIActionSheetDelegate,PassValueDelegate>
{
    UIButton *btn_picking;
    UIButton *btn_picked;
    UIView *blockView;
    NSIndexPath *current_confirm_path;
    UIView *_summaryView;
    UIView *_summaryView_bottom;
    UIButton *_sumBtn;
    UIButton *_selectAllBtn;
}
@property(nonatomic,retain) TransferModel *model;
@property(nonatomic,retain) NSString *order_ids;
@property(nonatomic,assign) int list_type;
@property(nonatomic,retain) NSString *target_shelf;//用于拣货中过来转移，提供的原货架号（就是往目的商品转移的目标货架）
@end
