//
//  BannerModel.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "ShelfEntity.h"

@interface TransferModel : SPBaseModel
@property (nonatomic,retain) ShelfEntity *entity;


-(void)loadShelfList:(NSString *)goods_id;

@end
