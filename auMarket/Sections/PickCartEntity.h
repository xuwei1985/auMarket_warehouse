//
//  BannerEntity.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "SPBaseEntity.h"
@class PickCartEntity;

@interface PickCartListEntity : SPBaseEntity
@property (nonatomic,retain) NSMutableArray<PickCartEntity*> *list;
@property (nonatomic,retain) NSString *tid;//最后的主键id
@property (nonatomic,retain) NSString *next;//下一页
@end

@interface PickCartEntity : SPBaseEntity
@property (nonatomic,retain) NSString *id;
@property (nonatomic,retain) NSString *cart_num;
@property (nonatomic,retain) NSString *current_block;
@property (nonatomic,retain) NSString *create_time;
@property (nonatomic,retain) NSString *order_num;
@end

