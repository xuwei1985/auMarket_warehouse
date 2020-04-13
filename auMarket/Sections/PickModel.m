//
//  BannerModel.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "PickModel.h"

@implementation PickModel

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

//加载待拣货的订单列表
-(void)loadOrdersWithListType:(int)list_type andRegionBlock:(int)region_block_id{
    self.parseDataClassType = [OrderEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/list?done=%d&region_block_id=%d&page=%@&token=%@",list_type,region_block_id,(self.entity.next==nil?@"1":self.entity.next),user.user_token];
    self.params = @{};
    self.requestTag=1001;
    [self loadInner];
}


//加载生成的订单的待拣货商品
-(void)loadGoodsListWithListType:(int)type{
    self.parseDataClassType = [PickGoodsListEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/goods?done=%d&token=%@",type,user.user_token];
    self.params = @{};
    self.requestTag=1002;
    [self loadInner];
}

//绑定货箱到订单
-(void)bindBoxToOrder:(NSString *)order_id andBoxCode:(NSString *)box_code{
    self.parseDataClassType = [SPBaseEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/box?order_id=%@&box=%@&token=%@",order_id,[box_code stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],user.user_token];
    self.params = @{};
    self.requestTag=1003;
    [self loadInner];
}

//设定生成开始
-(void)beginOrders:(NSString *)order_ids{
    self.parseDataClassType = [SPBaseEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/begin?order_id=%@&token=%@",order_ids,user.user_token];
    self.params = @{};
    self.requestTag=1004;
    [self loadInner];
}

//确认商品拣货
-(void)finishGoodsPick:(NSString *)rec_id andOrderId:(NSString *)order_id{
    self.parseDataClassType = [SPBaseEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/picking?order_id=%@&rec_id=%@&token=%@",order_id,rec_id,user.user_token];
    self.params = @{};
    self.requestTag=1005;
    [self loadInner];
}

//拣货分派
-(void)pickDispatch:(NSString *)cart_num andOrderId:(NSString *)order_id{
    self.parseDataClassType = [SPBaseEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/dispatch?cart_num=%@&order_id=%@&token=%@",cart_num,order_id,user.user_token];
    self.params = @{};
    self.requestTag=1007;
    [self loadInner];
}


-(void)finishAllGoodsPick{
    self.parseDataClassType = [SPBaseEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/picking-all?token=%@",user.user_token];
    self.params = @{};
    self.requestTag=1006;
    [self loadInner];
}


/*加载总单拣货的任务列表
 list_type 0：未拣货 1：已拣货
 */
-(void)loadBatchPickWithListType:(int)list_type{
    self.parseDataClassType = [BatchPickEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/batch-pick-list?model=%d&page=%@&token=%@",list_type,(self.entity.next==nil?@"1":self.entity.next),user.user_token];
    self.params = @{};
    self.requestTag=1010;
    [self loadInner];
}

/*加载总单拣货的任务里商品的分类
 */
-(void)loadBatchPickCategory:(NSString *)bid{
    self.parseDataClassType = [BatchPickCategoryEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/batch-pick-category-list?bid=%@&token=%@",bid,user.user_token];
    self.params = @{};
    self.requestTag=1011;
    [self loadInner];
}


/*总单拣货完成
 */
-(void)batchPickDone:(NSString *)bid{
    self.parseDataClassType = [SPBaseEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/batch-pick-done?bid=%@&token=%@",bid,user.user_token];
    self.params = @{};
    self.requestTag=1012;
    [self loadInner];
}


/*加载总单拣货的任务里商品
 */
-(void)loadBatchPickCategory:(NSString *)bid AndCatId:(NSString *)cat_id AndPage:(NSString *)page{
    page=(page==nil?@"1":page);
    self.parseDataClassType = [PickGoodsListEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/batch-pick-goods-list?bid=%@&cat_id=%@&page=%@&token=%@",bid,cat_id,page,user.user_token];
    self.params = @{};
    self.requestTag=1013;
    [self loadInner];
}


/*加载总单拣货的任务里的订单
 */
-(void)loadBatchPickOrderList:(NSString *)bid{
    self.parseDataClassType = [OrderEntity class];
    SPAccount *user=[[AccountManager sharedInstance] getCurrentUser];
    self.shortRequestAddress= [NSString stringWithFormat:@"v1/pick/batch-pick-order-list?bid=%@&token=%@",bid,user.user_token];
    self.params = @{};
    self.requestTag=1014;
    [self loadInner];
}

-(void)handleParsedData:(SPBaseEntity*)parsedData{
    if ([parsedData isKindOfClass:[OrderEntity class]]&&self.requestTag==1001) {
        self.entity = (OrderEntity*)parsedData;
    }
    else if (self.requestTag==1002&& [parsedData isKindOfClass:[PickGoodsListEntity class]]) {
        self.pickGoodsListEntity = (PickGoodsListEntity*)parsedData;
    }
    else if ([parsedData isKindOfClass:[BatchPickEntity class]]) {
        self.batchPickEntity = (BatchPickEntity*)parsedData;
    }
    else if ([parsedData isKindOfClass:[BatchPickCategoryEntity class]]) {
        self.batchPickCategoryEntity = (BatchPickCategoryEntity*)parsedData;
    }
    else if (self.requestTag==1012) {
       self.pickDoneEntity = (SPBaseEntity*)parsedData;
    }
    else if (self.requestTag==1013) {
       self.pickGoodsEntity = (PickGoodsListEntity*)parsedData;
    }
    else if (self.requestTag==1014) {
       self.pickOrderListEntity = (OrderEntity*)parsedData;
    }
}

-(OrderEntity *)entity{
    if(!_entity){
        _entity=[[OrderEntity alloc] init];    }
    
    return _entity;
}

-(PickGoodsListEntity *)pickGoodsListEntity{
    if(!_pickGoodsListEntity){
        _pickGoodsListEntity=[[PickGoodsListEntity alloc] init];
    }
    
    return _pickGoodsListEntity;
}


-(BatchPickEntity *)batchPickEntity{
    if(!_batchPickEntity){
        _batchPickEntity=[[BatchPickEntity alloc] init];
    }
    
    return _batchPickEntity;
}


-(BatchPickCategoryEntity *)batchPickCategoryEntity{
    if(!_batchPickCategoryEntity){
        _batchPickCategoryEntity=[[BatchPickCategoryEntity alloc] init];
    }
    
    return _batchPickCategoryEntity;
}


@end
