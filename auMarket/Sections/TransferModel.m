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
    self.parseDataClassType = [ShelfEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/ruku-goods/list-by-goods?goods_id=%@&goods_code=%@&shelves_code=%@&token=%@",goods_id,goods_code,shelf_code==nil?@"":shelf_code,user.user_token];
    self.params = @{};
    self.requestTag=1001;
    [self loadInner];
}


//添加待转移的商品到堆栈
-(void)addTransferToStack:(NSString *)ruku_id andNumber:(NSString *)num{
    self.parseDataClassType = [SPBaseEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/move/add?ruku_goods=%@&number=%@&token=%@",ruku_id,num,user.user_token];
    self.params = @{};
    self.requestTag=1002;
    [self loadInner];
}

//待转移的商品列表
-(void)goodsTransferList:(int)list_type{
    self.parseDataClassType = [TransferGoodsEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/move/list?moved=%d&token=%@",list_type,user.user_token];
    self.params = @{};
    self.requestTag=1003;
    [self loadInner];
}

//绑定商品到新货架
-(void)bindNewShelf:(NSString *)move_id andTargetShelf:(NSString *)target_shelf{
    self.parseDataClassType = [SPBaseEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/move/binding?id=%@&$shelves_code=%@&token=%@",move_id,target_shelf,user.user_token];
    self.params = @{};
    self.requestTag=1004;
    [self loadInner];
}



-(void)handleParsedData:(SPBaseEntity*)parsedData{
    if ([parsedData isKindOfClass:[ShelfEntity class]]) {
        self.entity = (ShelfEntity*)parsedData;
    }
    else if ([parsedData isKindOfClass:[TransferGoodsEntity class]]) {
        self.transfer_entity = (TransferGoodsEntity*)parsedData;
    }
}

-(ShelfEntity *)entity{
    if(!_entity){
        _entity=[[ShelfEntity alloc] init];
        _entity.err_msg=@"未获取到货架数据";
    }
    
    return _entity;
}

-(TransferGoodsEntity *)transfer_entity{
    if(!_transfer_entity){
        _transfer_entity=[[TransferGoodsEntity alloc] init];
        _transfer_entity.err_msg=@"未获取到转移数据";
    }
    
    return _transfer_entity;
}
@end
