//
//  BannerEntity.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "RegionBlockEntity.h"

@implementation RegionBlockListEntity
-(id)init{
    self = [super init];
    if (self) {
        [self addMappingRuleArrayProperty:@"list" class:[RegionBlockEntity class]];
    }
    return self;
}
@end


@implementation RegionBlockEntity : SPBaseEntity

@end

