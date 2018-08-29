//
//  BannerEntity.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "SPBaseEntity.h"
@class RegionBlockEntity;

@interface RegionBlockListEntity : SPBaseEntity
@property (nonatomic,retain) NSMutableArray<RegionBlockEntity*> *list;
@property (nonatomic,retain) NSString *tid;//下一页
@end

@interface RegionBlockEntity : SPBaseEntity
@property (nonatomic,retain) NSString *id;
@property (nonatomic,retain) NSString *name;
@end

