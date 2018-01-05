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
    self.shortRequestAddress= [NSString stringWithFormat:@"api_warehouse.php?act=batch_list&tid=%",(self.entity.tid==nil?@"0":self.entity.tid)];
    self.params = @{};
    self.requestTag=1001;
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
@end
