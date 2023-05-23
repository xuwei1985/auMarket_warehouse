//
//  BannerModel.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "BatchEntity.h"
#import "GoodsEntity.h"


//扫描模式
typedef enum : NSUInteger {
    SCAN_GOODS=0,//商品条形码
    SCAN_SHELF=1,//货架条形码
    SCAN_BOX=2,//货箱条形码
    SCAN_PICK_CART=3,//拣货车条形码
    SCAN_SHELF_BLOCK=4//货架区块条形码
} SCAN_MODEL;


@interface StockModel : SPBaseModel
@property (nonatomic,retain) BatchEntity *entity;
@property (nonatomic,retain) GoodsListEntity *goods_list_entity;

-(void)loadBatchs;
-(void)loadBindGoodsWithBatchId:(NSString *)batch_id;
-(void)addRukuGoods:(RukuGoodsEntity *)entity;
@end
