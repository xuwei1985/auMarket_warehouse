//
//  goodsBindViewController.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/8.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "SPBaseViewController.h"
#import "OrderItemCell.h"
#import "PickModel.h"


@interface PickOrderListViewController : SPBaseViewController
{

}
@property(nonatomic,retain) PickModel *model;
@property(nonatomic,retain) NSString *bid;
@end
