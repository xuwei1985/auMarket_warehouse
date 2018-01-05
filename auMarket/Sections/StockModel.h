//
//  BannerModel.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "StockModel.h"
#import "BatchEntity.h"

@interface StockModel : SPBaseModel
@property (nonatomic,retain) BatchEntity *entity;

-(void)loadBatchs;
@end
