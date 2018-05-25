//
//  GoodsCategoryParentCell.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/13.
//  Copyright © 2016年 daao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsEntity.h"

@protocol GoodsListItemCellDelegate
@required
- (void)addToStock:(NSString *)goodsId;
@end

@interface GoodsListItemCell : UITableViewCell{
    UILabel *_goodsTitleLbl;
    UILabel *_goodsPriceLbl;
    UILabel *_originalPriceLbl;
    UIImageView *_goodsImageView;
}

@property(nonatomic,retain)GoodsEntity *entity;
@property(nonatomic,assign)NSObject<GoodsListItemCellDelegate>* delegate;

@end
