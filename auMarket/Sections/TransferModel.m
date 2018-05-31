//
//  BannerModel.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "TransferModel.h"

@implementation TransferModel

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

//商品的货架列表
-(void)goodsShelfList:(NSString *)goods_id andGoodsCode:(NSString *)goods_code andShelf:(NSString *)shelf_code{
    self.parseDataClassType = [ShelfItemEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/ruku-goods/list-by-goods?goods_id=%@&goods_code=%@&shelves_code=%@&token=%@",goods_id,goods_code,shelf_code==nil?@"":shelf_code,user.user_token];
    self.params = @{};
    self.requestTag=1001;
    [self loadInner];
}


//添加待转移的商品到堆栈
-(void)addTransferToStack:(NSString *)goods_id andNewShelf:(NSString *)shelf andNumber:(NSString *)num{
    self.parseDataClassType = [SPBaseEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/move/add?ruku_goods=%@&new_shelves=%@&number=%@&token=%@",goods_id,shelf,num,user.user_token];
    self.params = @{};
    self.requestTag=1002;
    [self loadInner];
}



-(ShelfEntity *)entity{
    if(!_entity){
        _entity=[[ShelfEntity alloc] init];
        _entity.err_msg=@"未获取到货架数据";
    }
    
    return _entity;
}

@end
