//
//  BannerModel.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "RegionBlockEntity.h"

@interface RegionModel : SPBaseModel
@property (nonatomic,retain) RegionBlockListEntity *regionBlockList;

-(void)loadRegionBlocks;
@end
