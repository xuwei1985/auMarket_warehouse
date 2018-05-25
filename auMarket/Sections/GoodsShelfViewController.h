//
//  PickViewController.h
//  auMarket
//
//  Created by 吴绪伟 on 2018/1/4.
//  Copyright © 2018年 daao. All rights reserved.
//

#import "SPBaseViewController.h"
#import "GoodsShelfCell.h"
#import "GoodsEntity.h"

@interface GoodsShelfViewController : SPBaseViewController<UITextFieldDelegate>
{
    UIAlertView *_inputAlertView;
}
@property(nonatomic,retain) GoodsEntity *goods_entity;
@end
