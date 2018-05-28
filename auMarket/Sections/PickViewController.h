//
//  PickViewController.h
//  auMarket
//
//  Created by 吴绪伟 on 2018/1/4.
//  Copyright © 2018年 daao. All rights reserved.
//

#import "SPBaseViewController.h"
#import "PickGoodsViewController.h"
#import "PickOrderCell.h"
#import "PickModel.h"

@interface PickViewController : SPBaseViewController
{
    UIView *_summaryView;
    UIView *_summaryView_bottom;
    UIButton *_sumBtn;
    UIButton *_selectAllBtn;
}


@property(nonatomic,retain) PickModel *model;
@end
