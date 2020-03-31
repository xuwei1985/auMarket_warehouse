//
//  HomeViewController.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/8.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "SPBaseViewController.h"
#import "PickModel.h"
#import "BatchPickGoodsCell.h"
#import <MJRefresh.h>

@interface BatchGoodsPickViewController : SPBaseViewController
{
    
}
@property(nonatomic,retain) PickModel *model;
@property(nonatomic,retain) NSString *cat_id;
@property(nonatomic,retain) NSString *b_id;
@end
