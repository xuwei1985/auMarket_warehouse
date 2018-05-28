//
//  BannerEntity.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "SPBaseEntity.h"
@class OrderItemEntity,PackageFormEntity;

@interface OrderEntity : SPBaseEntity
@property (nonatomic,retain) NSMutableArray<OrderItemEntity*> *list;
@property (nonatomic,retain) NSString *next;//下一页
@end

@interface OrderItemEntity : SPBaseEntity
@property (nonatomic,retain) NSString *order_id;
@property (nonatomic,retain) NSString *order_sn;
@property (nonatomic,retain) NSString *total_price;
@property (nonatomic,retain) NSString *goods_count;
@property (nonatomic,retain) NSString *region_name;
@property (nonatomic,retain) PackageFormEntity *attribute;
@property (nonatomic,retain) NSString *box_code;//绑定的货箱码
@end

@interface PackageFormEntity : SPBaseEntity
@property (nonatomic,retain) NSString *frozen;
@property (nonatomic,retain) NSString *cold;
@property (nonatomic,retain) NSString *package;
@end
