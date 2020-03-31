//
//  BannerEntity.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "SPBaseEntity.h"
@class PickTaskEntity;

@interface BatchPickEntity : SPBaseEntity
@property (nonatomic,retain) NSMutableArray<PickTaskEntity*> *list;
@property (nonatomic,retain) NSString *next;//下一页
@end

@interface PickTaskEntity : SPBaseEntity
@property (nonatomic,retain) NSString *id;
@property (nonatomic,retain) NSString *order_sn;
@property (nonatomic,retain) NSString *goods_sku;
@property (nonatomic,retain) NSString *create_time;
@property (nonatomic,retain) NSString *goods_number;
@end

