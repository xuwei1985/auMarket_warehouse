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

@property (nonatomic,retain) NSString *shelves_id;
@property (nonatomic,retain) NSString *batch_id;
@property (nonatomic,retain) NSString *expired_date;
@property (nonatomic,retain) NSString *created_at;
@property (nonatomic,retain) NSString *batch_no;
@property (nonatomic,retain) NSString *shelves_code;
@property (nonatomic,retain) NSString *inventory;//库存量
@property (nonatomic,retain) NSString *number;//进货量
@property (nonatomic,retain) NSString *transfer_number;//待转移数量
@end
