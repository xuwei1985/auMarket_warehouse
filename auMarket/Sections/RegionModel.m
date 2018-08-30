//
//  BannerModel.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "RegionModel.h"

@implementation RegionModel

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}


//加载区块数据
-(void)loadRegionBlocks{
    self.parseDataClassType = [RegionBlockListEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/region-block-list?&token=%@",user.user_token];
    self.params = @{};
    self.requestTag=2001;
    [self loadInner];
}

-(void)handleParsedData:(SPBaseEntity*)parsedData{
    if ([parsedData isKindOfClass:[RegionBlockListEntity class]]) {
        self.regionBlockList = (RegionBlockListEntity*)parsedData;
    }
}

-(RegionBlockListEntity *)regionBlockList{
    if(!_regionBlockList){
        _regionBlockList=[[RegionBlockListEntity alloc] init];
    }
    
    return _regionBlockList;
}

@end
