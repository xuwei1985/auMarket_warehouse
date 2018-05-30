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

//加载商品的货架列表
-(void)loadShelfList:(NSString *)goods_id{
    self.parseDataClassType = [ShelfEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/list?page=%@&token=%@",(self.entity.next==nil?@"1":self.entity.next),user.user_token];
    self.params = @{};
    self.requestTag=1001;
    [self loadInner];
}

//添加待转移的商品到堆栈
-(void)addTransferToStack:(NSString *)goods_id andNewShelf:(NSString *)shelf andNumber:(int)num{
    self.parseDataClassType = [SPBaseEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/move/add?ruku_goods=%@&new_shelves=%@&number=%d&token=%@",goods_id,shelf,num,user.user_token];
    self.params = @{};
    self.requestTag=1002;
    [self loadInner];
}

//添加待转移的商品到堆栈
-(void)goodsShelfList:(NSString *)goods_id andNewShelf:(NSString *)shelf andNumber:(int)num{
    self.parseDataClassType = [SPBaseEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/move/add?ruku_goods=%@&new_shelves=%@&number=%d&token=%@",goods_id,shelf,num,user.user_token];
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
