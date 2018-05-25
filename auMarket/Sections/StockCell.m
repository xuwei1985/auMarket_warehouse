//
//  MemberCell.m
//  XiaoYa
//
//  Created by XuWei on 15/1/3.
//  Copyright (c) 2015年 xuwei. All rights reserved.
//

#import "StockCell.h"

@implementation StockCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        @weakify(self);
        if (info_icon==nil) {
            info_icon=[[UIImageView alloc] init];
            [self.contentView addSubview:info_icon];

            [info_icon mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.centerY.mas_equalTo(self.mas_centerY);
                make.left.mas_equalTo(10);
                make.size.mas_equalTo(CGSizeMake(32, 32));
            }];
        }
        
        if (info_arrow==nil) {
            info_arrow=[[UIImageView alloc] init];
            info_arrow.image=[UIImage imageNamed:@"stock_arrow"];
            [self.contentView addSubview:info_arrow];
            
            [info_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.centerY.mas_equalTo(self.mas_centerY);
                make.right.mas_equalTo(-2);
                make.size.mas_equalTo(CGSizeMake(32, 32));
            }];
        }
        
        if (lbl_info_title==nil) {
            lbl_info_title=[[UILabel alloc] init];
            lbl_info_title.textAlignment=NSTextAlignmentLeft;
            lbl_info_title.textColor=COLOR_DARKGRAY;
            lbl_info_title.font=FONT_SIZE_MIDDLE;
            [self.contentView addSubview:lbl_info_title];
            
            [lbl_info_title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(12);
                make.left.mas_equalTo(info_icon.mas_right).offset(5);
                make.size.mas_equalTo(CGSizeMake(150, 28));
            }];
            
            lbl_info_value=[[UILabel alloc] init];
            lbl_info_value.textAlignment=NSTextAlignmentRight;
            lbl_info_value.textColor=COLOR_GRAY;
            lbl_info_value.font=FONT_SIZE_MIDDLE;
            [self.contentView addSubview:lbl_info_value];
            
            [lbl_info_value mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.centerY.mas_equalTo(self.mas_centerY);
                make.right.mas_equalTo(self.mas_right).offset(-35);
                make.height.mas_equalTo(24);
            }];
        }
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    info_icon.image=[UIImage imageNamed:self.info_icon_name];
    lbl_info_value.text=self.info_value;
    lbl_info_title.text=self.info_title;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
