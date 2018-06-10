//
//  PickViewController.h
//  auMarket
//
//  Created by 吴绪伟 on 2018/1/4.
//  Copyright © 2018年 daao. All rights reserved.
//

#import "SPBaseViewController.h"
#import "GoodsShelfCell.h"
#import "GoodsEntity.h"
#import "TransferModel.h"
#import "TransferGoodsViewController.h"

@interface GoodsShelfViewController : SPBaseViewController<UITextFieldDelegate>
{
    UIAlertView *_inputAlertView;
    UILabel *lbl_transfer_num;
    BOOL hasHideTransferNum;
}

@property(nonatomic,retain) GoodsEntity *goods_entity;
@property(nonatomic,retain) TransferModel *model;
@property(nonatomic,assign) BOOL from_pick;//用于拣货中的商品过来转移库存使用
@property(nonatomic,retain) NSIndexPath *inputPath;
@end
