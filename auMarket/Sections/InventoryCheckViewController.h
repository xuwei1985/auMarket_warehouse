//
//  PickViewController.h
//  auMarket
//
//  Created by 吴绪伟 on 2018/1/4.
//  Copyright © 2018年 daao. All rights reserved.
//

#import "SPBaseViewController.h"
#import "InventoryCheckCell.h"
#import "GoodsEntity.h"
#import "TransferModel.h"
#import "TransferGoodsViewController.h"


@interface InventoryCheckViewController : SPBaseViewController<UITextFieldDelegate,PassValueDelegate>
{
    UIAlertView *_inputAlertView;
    UILabel *lbl_transfer_num;
    BOOL hasHideTransferNum;
    UIImageView *scanGoodsImg;
    UIImageView *goods_img;
    UILabel *goodsNameLbl;
    UILabel *goodsPriceLbl;
}

@property(nonatomic,retain) GoodsEntity *goods_entity;
@property(nonatomic,retain) TransferModel *model;
@property(nonatomic,retain) GoodsListModel *goods_model;
@property(nonatomic,retain) NSIndexPath *inputPath;
@property(nonatomic,retain) NSString *goods_code;
@end
