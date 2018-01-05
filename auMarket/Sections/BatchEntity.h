//
//  BannerEntity.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/28.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "SPBaseEntity.h"
@class BatchItemEntity;

@interface BatchEntity : SPBaseEntity
@property (nonatomic,retain) NSMutableArray<BatchItemEntity*> *list;
@property (nonatomic,retain) NSString *tid;//下一页
@end

@interface BatchItemEntity : SPBaseEntity
@property (nonatomic,retain) NSString *id;
@property (nonatomic,retain) NSString *batch_no;
@property (nonatomic,retain) NSString *suppliers_name;
@property (nonatomic,retain) NSString *created_at;
@end
