//
//  BannerModel.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "ShelfEntity.h"
#import "TransferGoodsEntity.h"

@interface TransferModel : SPBaseModel
@property (nonatomic,retain) ShelfEntity *entity;
@property (nonatomic,retain) TransferGoodsEntity *transfer_entity;


-(void)goodsShelfList:(NSString *)goods_id andGoodsCode:(NSString *)goods_code andShelf:(NSString *)shelf_code;
-(void)addTransferToStack:(NSString *)ruku_id andNumber:(NSString *)num andNewShelf:(NSString *)new_Shelf;
-(void)goodsTransferList:(int)list_type andTargetShelf:(NSString *)target_shelf;
-(void)bindNewShelf:(NSString *)move_id andTargetShelf:(NSString *)target_shelf;
-(void)unBind:(NSString *)move_id;
-(void)transferGoods:(NSString *)move_ids;
-(void)transferGoodsDirectly:(NSString *)ruku_id andShelves:(NSString *)shelves_code;
//重新绑定商品的所以入库记录到目标货架
-(void)rebindGoods:(NSString *)goods_id andShelf:(NSString *)shelf_code;
@end
