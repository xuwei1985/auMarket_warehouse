//
//  GoodsInfoEntity.h
//  auMarket
//
//  Created by 吴绪伟 on 2017/2/19.
//  Copyright © 2017年 daao. All rights reserved.
//

#import "SPBaseEntity.h"

@interface GoodsInfoEntity : SPBaseEntity
@property(nonatomic,retain)NSString *goods_id;
@property(nonatomic,retain)NSString *cat_id;
@property(nonatomic,retain)NSString *goods_name;
@property(nonatomic,retain)NSString *goods_number;
@property(nonatomic,retain)NSString *market_price;
@property(nonatomic,retain)NSString *shop_price;
@property(nonatomic,retain)NSString *promote_price;//促销价格
@property(nonatomic,retain)NSString *promote_start_date;//促销开始时间
@property(nonatomic,retain)NSString *promote_end_date;//促销结束时间
@property(nonatomic,retain)NSString *is_promote;//是否促销
@property(nonatomic,retain)NSString *is_new;
@property(nonatomic,retain)NSString *is_best;
@property(nonatomic,retain)NSString *is_hot;
@property(nonatomic,retain)NSString *is_shipping;
@property(nonatomic,retain)NSString *is_fixed_point;//是否只发特定城市
@property(nonatomic,retain)NSString *goods_type;
@property(nonatomic,retain)NSString *goods_thumb;
@property(nonatomic,retain)NSString *goods_weight;
@property(nonatomic,retain)NSString *goods_img;
@property(nonatomic,retain)NSString *original_img;
@property(nonatomic,retain)NSString *collection_id;
@property(nonatomic,retain)NSString *is_on_sale;//是否在售
@property(nonatomic,retain)NSString *is_alone_sale;//是否单独销售
@property(nonatomic,retain)NSString *buy_number;
@property(nonatomic,retain)NSString *rec_id;
@property(nonatomic,retain)NSString *sel_state;

-(BOOL)isPromote;
@end

