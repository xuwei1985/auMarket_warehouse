//
//  ToolsViewController.h
//  auMarket
//
//  Created by 吴绪伟 on 2018/5/19.
//  Copyright © 2018 daao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BatchGoodsPickViewController.h"
#import "PickModel.h"
#import "PickCategoryCell.h"

@interface BatchPickCategoryViewController : SPBaseViewController
{
    UIButton *doneBtn;
}
@property(nonatomic,retain) PickModel *model;
@property(nonatomic,retain) NSString *bid;
@property(nonatomic,assign) int dataModel;//2:冷冻冷藏模式 3:熟食模式
@end
