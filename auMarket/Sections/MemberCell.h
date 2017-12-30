//
//  MemberCell.h
//  XiaoYa
//
//  Created by XuWei on 15/1/3.
//  Copyright (c) 2015年 xuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberCell : UITableViewCell
{
    UIImageView *_iconImageView;
    UILabel *_itemLbl;
    UISwitch* _mySwitch;
}

@property(nonatomic,retain) UIImage *iconImage;
@property(nonatomic,retain) NSString *itemName;
@property(nonatomic,retain) NSString *itemPrice;
@end
