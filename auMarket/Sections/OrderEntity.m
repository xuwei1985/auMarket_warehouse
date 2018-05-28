//
//  BannerEntity.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "OrderEntity.h"

@implementation OrderEntity
-(id)init{
    self = [super init];
    if (self) {
        [self addMappingRuleArrayProperty:@"list" class:[OrderItemEntity class]];
    }
    return self;
}
@end


@implementation OrderItemEntity : SPBaseEntity

@end

@implementation PackageFormEntity : SPBaseEntity

@end

