//
//  BannerEntity.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "BatchEntity.h"

@implementation BatchEntity
-(id)init{
    self = [super init];
    if (self) {
        [self addMappingRuleArrayProperty:@"list" class:[BatchItemEntity class]];
    }
    return self;
}
@end


@implementation BatchItemEntity : SPBaseEntity

@end
