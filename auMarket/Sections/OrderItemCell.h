//
//  GoodsCategoryParentCell.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/13.
//  Copyright © 2016年 daao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderEntity.h"


@interface OrderItemCell : UITableViewCell{
    UILabel *_orderSnTitleLbl;
    UILabel *_orderSnValueLbl;
    UILabel *_orderPriceTitleLbl;
    UILabel *_orderPriceValueLbl;
    UILabel *_lbl_status;
}

@property(nonatomic,retain)OrderItemEntity *entity;
-(void)loadData;
@end
