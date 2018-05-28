//
//  MemberCell.h
//  XiaoYa
//
//  Created by XuWei on 15/1/3.
//  Copyright (c) 2015年 xuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsEntity.h"

@interface PickGoodsCell : UITableViewCell
{
    UIImageView *_iconImageView;
    UILabel *_itemLbl;
    UILabel *_numLbl;
    UILabel *_priceLbl;
    UILabel *_totalPriceLbl;
    UILabel *_shelf_no;
}

@property(nonatomic,retain) GoodsEntity *entity;
@end
