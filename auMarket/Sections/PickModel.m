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

//加载待拣货的订单列表
-(void)loadOrdersWithListType:(int)list_type andRegionBlock:(int)region_block_id{
    self.parseDataClassType = [OrderEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/list?done=%d&region_block_id=%d&page=%@&token=%@",list_type,region_block_id,(self.entity.next==nil?@"1":self.entity.next),user.user_token];
    self.params = @{};
    self.requestTag=1001;
    [self loadInner];
}

-(void)loadRegions{
    self.parseDataClassType = [OrderEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/list?done=%d&page=%@&token=%@",list_type,(self.entity.next==nil?@"1":self.entity.next),user.user_token];
    self.params = @{};
    self.requestTag=1001;
    [self loadInner];
}


//加载生成的订单的待拣货商品
-(void)loadGoodsListWithListType:(int)type{
    self.parseDataClassType = [PickGoodsListEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/goods?done=%d&token=%@",type,user.user_token];
    self.params = @{};
    self.requestTag=1002;
    [self loadInner];
}

//绑定货箱到订单
-(void)bindBoxToOrder:(NSString *)order_id andBoxCode:(NSString *)box_code{
    self.parseDataClassType = [SPBaseEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/box?order_id=%@&box=%@&token=%@",order_id,[box_code stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],user.user_token];
    self.params = @{};
    self.requestTag=1003;
    [self loadInner];
}

//设定生成开始
-(void)beginOrders:(NSString *)order_ids{
    self.parseDataClassType = [SPBaseEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/begin?order_id=%@&token=%@",order_ids,user.user_token];
    self.params = @{};
    self.requestTag=1004;
    [self loadInner];
}

//确认商品拣货
-(void)finishGoodsPick:(NSString *)rec_id andOrderId:(NSString *)order_id{
    self.parseDataClassType = [SPBaseEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/picking?order_id=%@&rec_id=%@&token=%@",order_id,rec_id,user.user_token];
    self.params = @{};
    self.requestTag=1005;
    [self loadInner];
}

-(void)finishAllGoodsPick{
    self.parseDataClassType = [SPBaseEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/picking-all?token=%@",user.user_token];
    self.params = @{};
    self.requestTag=1006;
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
        _entity=[[OrderEntity alloc] init];    }
    
    return _entity;
}

-(PickGoodsListEntity *)pickGoodsListEntity{
    if(!_pickGoodsListEntity){
        _pickGoodsListEntity=[[PickGoodsListEntity alloc] init];
    }
    
    return _pickGoodsListEntity;
}



@end
