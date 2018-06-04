//
//  BannerModel.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "StockModel.h"

@implementation StockModel

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)loadBatchs{
    self.parseDataClassType = [BatchEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/batch/list?page=%@&token=%@",(self.entity.next==nil?@"1":self.entity.next),user.user_token];
    self.params = @{};
    self.requestTag=1001;
    [self loadInner];
}

-(void)loadBindGoodsWithBatchId:(NSString *)batch_id{
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.parseDataClassType = [GoodsListEntity class];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/ruku-goods/list?batch_id=%@&token=%@",batch_id,user.user_token];
    self.params = @{};
    self.requestTag=1002;
    [self loadInner];
}

-(void)addRukuGoods:(RukuGoodsEntity *)entity{
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.parseDataClassType = [GoodsListEntity class];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/ruku-goods/add?token=%@",user.user_token];
    self.params = @{
                    @"batch_id":entity.batch_id,
                    @"goods_id":entity.goods_id,
                    @"goods_code":entity.goods_code,
                    @"number":entity.number,
                    @"cost":entity.cost,
                    @"expired_date":entity.expired_date,
                    @"no":entity.no,
                    @"shelves_code":entity.shelves_code
                    };
    self.requestTag=1003;
    [self loadInner];
}

-(void)handleParsedData:(SPBaseEntity*)parsedData{
    if ([parsedData isKindOfClass:[BatchEntity class]]) {
        self.entity = (BatchEntity*)parsedData;
    }
    else if ([parsedData isKindOfClass:[GoodsListEntity class]]) {
        self.goods_list_entity = (GoodsListEntity*)parsedData;
    }
}

-(BatchEntity *)entity{
    if(!_entity){
        _entity=[[BatchEntity alloc] init];
    }
    
    return _entity;
}


-(GoodsListEntity *)goods_list_entity{
    if(!_goods_list_entity){
        _goods_list_entity=[[GoodsListEntity alloc] init];
    }
    
    return _goods_list_entity;
}
@end
