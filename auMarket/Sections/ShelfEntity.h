//
//  BannerEntity.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "SPBaseEntity.h"
@class ShelfItemEntity;

@interface ShelfEntity : SPBaseEntity
@property (nonatomic,retain) NSMutableArray<ShelfItemEntity*> *list;
@property (nonatomic,retain) NSString *next;//下一页
@end

@interface ShelfItemEntity : SPBaseEntity
@property (nonatomic,retain) NSString *id;
@property (nonatomic,retain) NSString *shelves_id;
@property (nonatomic,retain) NSString *batch_id;
@property (nonatomic,retain) NSString *expired_date;
@property (nonatomic,retain) NSString *created_at;
@property (nonatomic,retain) NSString *batch_no;
@property (nonatomic,retain) NSString *shelves_code;
@property (nonatomic,retain) NSString *storage;//货架标记0（普通货架）；1（存储货架）
@property (nonatomic,retain) NSString *inventory;//库存量
@property (nonatomic,retain) NSString *number;//当前用户正购买的商品量，还未拣货
@property (nonatomic,retain) NSString *move_number;//待转移数量(这个货架上已经入库的)
@property (nonatomic,retain) NSString *transfer_number;//待转移数量（现在需要转移的）
@end
