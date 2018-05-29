//
//  BannerModel.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "OrderEntity.h"

@interface PickModel : SPBaseModel
@property (nonatomic,retain) OrderEntity *entity;

-(void)loadOrderList;
-(void)loadGoodsListWithOrderIds:(NSString *)order_ids andType:(int)type;
@end
