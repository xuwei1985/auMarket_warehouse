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

-(void)loadGoodsListWithOrderIds:(NSString *)order_ids andType:(int)type{
    self.parseDataClassType = [OrderEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/goods?order_id=%@&done=%d&token=%@",order_ids,type,user.user_token];
    self.params = @{};
    self.requestTag=1002;
    [self loadInner];
}

-(void)handleParsedData:(SPBaseEntity*)parsedData{
    if ([parsedData isKindOfClass:[OrderEntity class]]) {
        self.entity = (OrderEntity*)parsedData;
    }
}

-(OrderEntity *)entity{
    if(!_entity){
        _entity=[[OrderEntity alloc] init];
        _entity.err_msg=@"未获取到有效的订单数据";
    }
    
    return _entity;
}

@end
