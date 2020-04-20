//
//  goodsBindViewController.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/8.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "SPBaseViewController.h"
#import "StockViewController.h"
#import "PickCartCell.h"
#import "PickModel.h"
#import "GoodsShelfViewController.h"

@interface PickCartViewController : SPBaseViewController<UIActionSheetDelegate,UITextFieldDelegate>
{
    UIButton *btn_picking;
    UIButton *btn_picked;
    UIView *blockView;
    NSIndexPath *current_confirm_path;
    UIAlertView *_inputAlertView;
    UIButton *doneBtn;
}
@property(nonatomic,retain) PickModel *model;
@property(nonatomic,retain) NSString *order_ids;
@property(nonatomic,assign) int list_type;
@property(nonatomic,assign) BOOL isGotoShelvesView;//是否前往了货架列表准备去转移库存的
@end
