//
//  GoodsCategoryModel.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/12.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "GoodsListModel.h"


@implementation GoodsListModel

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)loadGoodsList:(NSString *)goods_code orGoodsName:(NSString *)goods_name{
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.parseDataClassType = [GoodsListEntity class];
    self.shortRequestAddress=[NSString stringWithFormat:@"v1/goods/search?goods_code=%@&goods_name=%@&token=%@",(goods_code==nil?@"":[goods_code stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]),(goods_name==nil?@"":[goods_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]),user.user_token];
    self.params = @{};
    self.requestTag=1001;
    
    [self loadInner];
}

-(void)adjustInventory:(NSString *)goods_id andNum:(int)num andAction:(int)action{
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.parseDataClassType = [SPBaseEntity class];
    self.shortRequestAddress=[NSString stringWithFormat:@"v1/goods/adjust-inventory?goods_id=%@&number=%d&act_type=%d&token=%@",goods_id,num,action,user.user_token];
    self.params = @{};
    self.requestTag=1002;
    
    [self loadInner];
}

-(void)handleParsedData:(SPBaseEntity*)parsedData{
    if ([parsedData isKindOfClass:[GoodsListEntity class]]) {
        self.entity = (GoodsListEntity*)parsedData;
    }
    else{
        self.i_entity = (SPBaseEntity*)parsedData;
    }
}


-(GoodsListEntity *)entity{
    if(!_entity){
        _entity=[[GoodsListEntity alloc] init];
    }
    
    return _entity;
}
@end
