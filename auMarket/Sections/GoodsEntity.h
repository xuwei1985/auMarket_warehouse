//
//  BannerEntity.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "SPBaseEntity.h"
@class GoodsEntity;

@interface GoodsListEntity : SPBaseEntity
@property (nonatomic,retain) NSMutableArray<GoodsEntity*> *list;
@property (nonatomic,retain) NSString *tid;//下一页
@end

@interface GoodsEntity : SPBaseEntity
@property (nonatomic,retain) NSString *goods_id;
@property(nonatomic,retain)NSString *cat_id;
@property (nonatomic,retain) NSString *goods_name;
@property (nonatomic,retain) NSString *shop_price;
@property (nonatomic,retain) NSString *cost;
@property (nonatomic,retain) NSString *goods_thumb;
@property (nonatomic,retain) NSString *goods_number;
@property (nonatomic,retain) NSString *promote_price;
@property(nonatomic,retain) NSString *is_promote;//是否促销
@property(nonatomic,retain) NSString *promote_start_date;
@property(nonatomic,retain) NSString *promote_end_date;
@property (nonatomic,retain) NSString *batch_no;
@property (nonatomic,retain) NSString *suppliers_name;
@property (nonatomic,retain) NSString *created_at;

-(BOOL)isPromote;
@end
