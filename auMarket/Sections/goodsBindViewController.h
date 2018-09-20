//
//  goodsBindViewController.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/8.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "SPBaseViewController.h"
#import "StockViewController.h"
#import "GoodsBindCell.h"
#import "QRCodeViewController.h"
#import "TransferModel.h"

@interface GoodsBindViewController : SPBaseViewController<UIActionSheetDelegate,PassValueDelegate>
{
    UILabel *lbl_goodsNum;
    UILabel *lbl_sumPrice;
    UIButton *_btn_doneAction;
    GoodsEntity *select_entity;
    NSString *scan_shelf_code;
    BOOL isGotoBindGoods;//是否去添加商品了，回来强制刷新列表
}
@property(nonatomic,retain) StockModel *model;
@property(nonatomic,retain) TransferModel *transfer_model;
@property(nonatomic,retain) NSString *batch_id;
@end
