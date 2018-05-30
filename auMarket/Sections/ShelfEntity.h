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
@property (nonatomic,retain) NSString *order_id;
@property (nonatomic,retain) NSString *order_sn;
@property (nonatomic,retain) NSString *total_price;
@property (nonatomic,retain) NSString *goods_count;
@property (nonatomic,retain) NSString *region_name;
@property (nonatomic,retain) NSString *box;//绑定的货箱码
@property (nonatomic,assign) BOOL selected;//是否选中
@end
