//
//  MemberCell.h
//  XiaoYa
//
//  Created by XuWei on 15/1/3.
//  Copyright (c) 2015年 xuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BatchEntity.h"

typedef void(^AddGoodsBlock)(NSString *batch_id);

@interface BatchCell : UITableViewCell
{
    UIImageView *imv_addGoods;
    UILabel *lbl_batchNo_prefix;
    UILabel *lbl_batchNo;
    UILabel *lbl_suppliersName_prefix;
    UILabel *lbl_suppliersName;
    UILabel *lbl_editTime_prefix;
    UILabel *lbl_editTime;
    UILabel *lbl_needbind_prefix;
    UILabel *lbl_needbind;
}

@property(nonatomic,retain) BatchItemEntity *entity;
@property (nonatomic, copy) AddGoodsBlock addGoodsBlock;

-(void)returnBatchId:(AddGoodsBlock)block;
@end
