//
//  BannerModel.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "BatchEntity.h"
#import "GoodsEntity.h"

@interface StockModel : SPBaseModel
@property (nonatomic,retain) BatchEntity *entity;
@property (nonatomic,retain) GoodsListEntity *goods_list_entity;

-(void)loadBatchs;
-(void)loadBindGoodsWithBatchId:(NSString *)batch_id;
-(void)addRukuGoods:(RukuGoodsEntity *)entity;
@end
