//
//  BannerEntity.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "GoodsEntity.h"

@implementation GoodsListEntity
-(id)init{
    self = [super init];
    if (self) {
        [self addMappingRuleArrayProperty:@"list" class:[GoodsEntity class]];
    }
    return self;
}
@end


@implementation GoodsEntity : SPBaseEntity
//是否是促销商品
-(BOOL)isPromote{
    int timestamp=[[Common getNowTimeTimestamp] intValue];
    if([self.is_promote intValue]==1&&[self.promote_start_date intValue]<=timestamp&&[self.promote_end_date intValue]>timestamp){
        return YES;
    }
    return NO;
}
@end
