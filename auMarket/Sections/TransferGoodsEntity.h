//
//  BannerEntity.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "SPBaseEntity.h"
@class TransferGoodsItemEntity;

@interface TransferGoodsEntity : SPBaseEntity
@property (nonatomic,retain) NSMutableArray<TransferGoodsItemEntity*> *list;
@property (nonatomic,retain) NSString *next;//下一页
@end

@interface TransferGoodsItemEntity : SPBaseEntity
@property (nonatomic,retain) NSString *id;
@property (nonatomic,retain) NSString *number;
@property (nonatomic,retain) NSString *target_shelves;
@property (nonatomic,retain) NSString *old_shelves;
@property (nonatomic,retain) NSString *goods_name;
@property (nonatomic,retain) NSString *goods_thumb;
@property (nonatomic,retain) NSString *batch_no;
@property (nonatomic,assign) BOOL selected;
@end
