//
//  MemberCell.h
//  XiaoYa
//
//  Created by XuWei on 15/1/3.
//  Copyright (c) 2015年 xuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StockCell : UITableViewCell
{
    UIImageView *info_icon;
    UIImageView *info_arrow;
    UILabel *lbl_info_title;
    UILabel *lbl_info_value;
}

@property(nonatomic,retain) NSString *info_title;
@property(nonatomic,retain) NSString *info_icon_name;
@property(nonatomic,retain) NSString *info_value;


@end
