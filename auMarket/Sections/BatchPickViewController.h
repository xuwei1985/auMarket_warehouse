//
//  HomeViewController.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/8.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "SPBaseViewController.h"
#import "PickModel.h"
#import "BatchPickCell.h"
#import <MJRefresh.h>
#import "BatchPickCategoryViewController.h"
#import "PickOrderListViewController.h"

@interface BatchPickViewController : SPBaseViewController
{
    UIButton *doneBtn;
}
@property(nonatomic,retain) PickModel *model;
@property(nonatomic,assign) int listType;//0:未拣货任务 1:已拣货任务
@end
