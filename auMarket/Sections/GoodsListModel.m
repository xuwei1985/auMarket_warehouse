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
        self.parseDataClassType = [GoodsListEntity class];
        self.entity.err_msg=@"未获取到有效的商品数据";
    }
    return self;
}

-(void)loadGoodsList:(NSString *)goods_code orGoodsName:(NSString *)goods_name{
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress=[NSString stringWithFormat:@"v1/goods/search?goods_code=%@&goods_name=%@&token=%@",(goods_code==nil?@"":goods_code),(goods_name==nil?@"":[goods_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]),user.user_token];
    self.params = @{};
    self.requestTag=1001;
    
    [self loadInner];
}

-(void)handleParsedData:(SPBaseEntity*)parsedData{
    if ([parsedData isKindOfClass:[GoodsListEntity class]]) {
        self.entity = (GoodsListEntity*)parsedData;
    }
}


-(GoodsListEntity *)entity{
    if(!_entity){
        _entity=[[GoodsListEntity alloc] init];
    }
    
    return _entity;
}
@end
