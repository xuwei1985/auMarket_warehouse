//
//  BannerEntity.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "SPBaseEntity.h"
@class PickGoodsEntity;

@interface PickGoodsListEntity : SPBaseEntity
@property (nonatomic,retain) NSMutableArray<PickGoodsEntity*> *list;
@property (nonatomic,retain) NSString *tid;//下一页
@end

@interface PickGoodsEntity : SPBaseEntity
@property (nonatomic,retain) NSString *rec_id;
@property (nonatomic,retain) NSString *order_id;
@property (nonatomic,retain) NSString *goods_id;
@property (nonatomic,retain) NSString *goods_code;
@property (nonatomic,retain) NSString *goods_name;
@property (nonatomic,retain) NSString *pick_time;
@property (nonatomic,retain) NSString *goods_thumb;
@property (nonatomic,retain) NSString *shelves_code;
@property (nonatomic,retain) NSString *goods_number;
@property (nonatomic,retain) NSString *box;
@property (nonatomic,retain) NSString *goods_price;
@end

