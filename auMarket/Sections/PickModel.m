//
//  BannerModel.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "PickModel.h"

@implementation PickModel

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)loadOrderList{
    self.parseDataClassType = [OrderEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/list?page=%@&token=%@",(self.entity.next==nil?@"1":self.entity.next),user.user_token];
    self.params = @{};
    self.requestTag=1001;
    [self loadInner];
}

-(void)loadGoodsListWithOrderIds:(NSString *)order_ids{
    self.parseDataClassType = [PickGoodsListEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/goods?order_id=%@&token=%@",order_ids,user.user_token];
    self.params = @{};
    self.requestTag=1002;
    [self loadInner];
}

-(void)handleParsedData:(SPBaseEntity*)parsedData{
    if ([parsedData isKindOfClass:[OrderEntity class]]) {
        self.entity = (OrderEntity*)parsedData;
    }
    else if ([parsedData isKindOfClass:[PickGoodsListEntity class]]) {
        self.pickGoodsListEntity = (PickGoodsListEntity*)parsedData;
    }
}

-(OrderEntity *)entity{
    if(!_entity){
        _entity=[[OrderEntity alloc] init];
        _entity.err_msg=@"未获取到有效的订单数据";
    }
    
    return _entity;
}

-(PickGoodsListEntity *)pickGoodsListEntity{
    if(!_pickGoodsListEntity){
        _pickGoodsListEntity=[[PickGoodsListEntity alloc] init];
        _pickGoodsListEntity.err_msg=@"未获取到有效的订单数据";
    }
    
    return _pickGoodsListEntity;
}


@end
