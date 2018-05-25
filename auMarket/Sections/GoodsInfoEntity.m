//
//  GoodsInfoEntity.m
//  auMarket
//
//  Created by 吴绪伟 on 2017/2/19.
//  Copyright © 2017年 daao. All rights reserved.
//

#import "GoodsInfoEntity.h"

@implementation GoodsInfoEntity
//是否是促销商品
-(BOOL)isPromote{
//    int timestamp=[[Common getNowTimeTimestamp] intValue];
//    if([self.is_promote intValue]==1&&[self.promote_start_date intValue]<=timestamp&&[self.promote_end_date intValue]>timestamp){
//        return YES;
//    }
    return NO;
}
@end
