//
//  goodsBindViewController.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/8.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "SPBaseViewController.h"
#import "StockViewController.h"
#import "PickGoodsCell.h"
#import "PickModel.h"

@interface PickGoodsViewController : SPBaseViewController<UIActionSheetDelegate>
{
    UIButton *btn_picking;
    UIButton *btn_picked;
    UIView *blockView;
    NSIndexPath *current_confirm_path;
}
@property(nonatomic,retain) PickModel *model;
@property(nonatomic,retain) NSString *order_ids;
@property(nonatomic,assign) int list_type;
@end
