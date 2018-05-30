//
//  BannerModel.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "ShelfEntity.h"

@interface TransferModel : SPBaseModel
@property (nonatomic,retain) ShelfEntity *entity;


-(void)goodsShelfList:(NSString *)goods_id andGoodsCode:(NSString *)goods_code andShelf:(NSString *)shelf_code;
-(void)addTransferToStack:(NSString *)goods_id andNewShelf:(NSString *)shelf andNumber:(NSString *)num;
@end
