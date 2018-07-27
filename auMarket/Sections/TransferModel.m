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
-(void)addTransferToStack:(NSString *)ruku_id andNumber:(NSString *)num andNewShelf:(NSString *)new_Shelf{
    self.parseDataClassType = [SPBaseEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/move/add?ruku_goods=%@&number=%@&shelves_code=%@&token=%@",ruku_id,num,new_Shelf,user.user_token];
    self.params = @{};
    self.requestTag=1002;
    [self loadInner];
}

//待转移的商品列表
-(void)goodsTransferList:(int)list_type andTargetShelf:(NSString *)target_shelf{
    if(target_shelf==nil){
        target_shelf=@"";
    }
    self.parseDataClassType = [TransferGoodsEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/move/list?moved=%d&target_shelves=%@&token=%@",list_type,target_shelf,user.user_token];
    self.params = @{};
    self.requestTag=1003;
    [self loadInner];
}

//绑定商品到新货架
-(void)bindNewShelf:(NSString *)move_id andTargetShelf:(NSString *)target_shelf{
    self.parseDataClassType = [SPBaseEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/move/binding?id=%@&shelves_code=%@&token=%@",move_id,target_shelf,user.user_token];
    self.params = @{};
    self.requestTag=1004;
    [self loadInner];
}


//取消待绑定的商品
-(void)unBind:(NSString *)move_id{
    self.parseDataClassType = [SPBaseEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/move/delete?id=%@&token=%@",move_id,user.user_token];
    self.params = @{};
    self.requestTag=1005;
    [self loadInner];
}

//批量转移商品
-(void)transferGoods:(NSString *)move_ids{
    self.parseDataClassType = [SPBaseEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/move/move?ids=%@&token=%@",move_ids,user.user_token];
    self.params = @{};
    self.requestTag=1006;
    [self loadInner];
}

//直接转移到目标货架（仅限A1.1.1.1上的商品）
-(void)transferGoodsDirectly:(NSString *)ruku_id andShelves:(NSString *)shelves_code{
    self.parseDataClassType = [SPBaseEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/move/move-directly?ruku_id=%@&shelves_code=%@&token=%@",ruku_id,shelves_code,user.user_token];
    self.params = @{};
    self.requestTag=1007;
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
    }
    
    return _entity;
}

-(TransferGoodsEntity *)transfer_entity{
    if(!_transfer_entity){
        _transfer_entity=[[TransferGoodsEntity alloc] init];
    }
    
    return _transfer_entity;
}
@end
