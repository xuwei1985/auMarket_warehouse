//
//  BannerModel.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "OrderEntity.h"
#import "PickGoodsEntity.h"

@interface PickModel : SPBaseModel
@property (nonatomic,retain) OrderEntity *entity;
@property (nonatomic,retain) PickGoodsListEntity *pickGoodsListEntity;

-(void)loadOrderList;
-(void)loadGoodsListWithOrderIds:(NSString *)order_ids andListType:(int)type;
-(void)bindBoxToOrder:(NSString *)order_id andBoxCode:(NSString *)box_code;
@end
