//
//  MemberCell.h
//  XiaoYa
//
//  Created by XuWei on 15/1/3.
//  Copyright (c) 2015年 xuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PickCartEntity.h"

@interface PickCartCell : UITableViewCell
{
    UILabel *lbl_cart_name;
    UILabel *lbl_dispatch_time;
    UILabel *lbl_order_num;
    UILabel *lbl_block;
}

@property(nonatomic,retain) PickCartEntity *entity;
@end
