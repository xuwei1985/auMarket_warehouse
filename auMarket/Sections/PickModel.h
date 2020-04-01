//
//  BannerModel.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "OrderEntity.h"
#import "PickGoodsEntity.h"
#import "BatchPickEntity.h"
#import "BatchPickCategoryEntity.h"

@interface PickModel : SPBaseModel
@property (nonatomic,retain) OrderEntity *entity;
@property (nonatomic,retain) PickGoodsListEntity *pickGoodsListEntity;
@property (nonatomic,retain) BatchPickEntity *batchPickEntity;
@property (nonatomic,retain) BatchPickCategoryEntity *batchPickCategoryEntity;
@property (nonatomic,retain) SPBaseEntity *pickDoneEntity;
@property (nonatomic,retain) PickGoodsListEntity *pickGoodsEntity;
@property (nonatomic,retain) OrderEntity *pickOrderListEntity;

-(void)loadOrdersWithListType:(int)list_type andRegionBlock:(int)region_block_id;
-(void)loadGoodsListWithListType:(int)type;
-(void)bindBoxToOrder:(NSString *)order_id andBoxCode:(NSString *)box_code;
-(void)beginOrders:(NSString *)order_ids;
-(void)finishGoodsPick:(NSString *)rec_id andOrderId:(NSString *)order_id;
-(void)finishAllGoodsPick;
-(void)loadBatchPickWithListType:(int)list_type;
-(void)loadBatchPickCategory:(NSString *)bid;
-(void)batchPickDone:(NSString *)bid;
-(void)loadBatchPickCategory:(NSString *)bid AndCatId:(NSString *)cat_id AndPage:(NSString *)page;
-(void)loadBatchPickOrderList:(NSString *)bid;
@end
