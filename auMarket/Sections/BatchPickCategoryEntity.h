//
//  BannerEntity.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "SPBaseEntity.h"
@class PickCategoryEntity;

@interface BatchPickCategoryEntity : SPBaseEntity
@property (nonatomic,retain) NSMutableArray<PickCategoryEntity*> *list;
@property (nonatomic,retain) NSString *next;//下一页
@end

@interface PickCategoryEntity : SPBaseEntity
@property (nonatomic,retain) NSString *cat_id;
@property (nonatomic,retain) NSString *cat_icon;
@property (nonatomic,retain) NSString *cat_name;
@property (nonatomic,retain) NSString *goods_sku;
@property (nonatomic,retain) NSString *goods_number;
@end

