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

-(void)loadBindGoods{
    self.parseDataClassType = [GoodsListEntity class];
    self.shortRequestAddress= [NSString stringWithFormat:@"api_warehouse.php?act=batch_list&tid=%@",(self.entity.next==nil?@"0":self.entity.next)];
    self.params = @{};
    self.requestTag=1002;
    [self loadInner];
}

-(void)handleParsedData:(SPBaseEntity*)parsedData{
    if ([parsedData isKindOfClass:[BatchEntity class]]) {
        self.entity = (BatchEntity*)parsedData;
    }
}

-(BatchEntity *)entity{
    if(!_entity){
        _entity=[[BatchEntity alloc] init];
        _entity.err_msg=@"未获取到有效的批次数据";
    }
    
    return _entity;
}


-(GoodsListEntity *)goods_list_entity{
    if(!_goods_list_entity){
        _goods_list_entity=[[GoodsListEntity alloc] init];
        _goods_list_entity.err_msg=@"未获取到有效的数据";
    }
    
    return _goods_list_entity;
}
@end
