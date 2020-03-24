//
//  MemberCell.m
//  XiaoYa
//
//  Created by XuWei on 15/1/3.
//  Copyright (c) 2015年 xuwei. All rights reserved.
//

#import "BatchPickCell.h"

@implementation BatchPickCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        @weakify(self);

        if (lbl_batchNo==nil) {
            lbl_batchNo_prefix=[[UILabel alloc] init];
            lbl_batchNo_prefix.textAlignment=NSTextAlignmentLeft;
            lbl_batchNo_prefix.textColor=COLOR_BLACK;
            lbl_batchNo_prefix.font=FONT_SIZE_SMALL;
            lbl_batchNo_prefix.text=@"拣货单号:";
            [self.contentView addSubview:lbl_batchNo_prefix];
            
            [lbl_batchNo_prefix mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(12);
                make.left.mas_equalTo(15);
                make.size.mas_equalTo(CGSizeMake(78, 24));
            }];
            
            lbl_batchNo=[[UILabel alloc] init];
            lbl_batchNo.textAlignment=NSTextAlignmentLeft;
            lbl_batchNo.textColor=COLOR_BLACK;
            lbl_batchNo.font=FONT_SIZE_SMALL;
            [self.contentView addSubview:lbl_batchNo];
            
            [lbl_batchNo mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.top.mas_equalTo(12);
                make.left.mas_equalTo(lbl_batchNo_prefix.mas_right).offset(2);
                make.right.mas_equalTo(self.mas_right).offset(-10);
                make.height.mas_equalTo(24);
            }];
        }
        
        if (lbl_suppliersName==nil) {
            lbl_suppliersName_prefix=[[UILabel alloc] init];
            lbl_suppliersName_prefix.textAlignment=NSTextAlignmentLeft;
            lbl_suppliersName_prefix.textColor=COLOR_BLACK;
            lbl_suppliersName_prefix.font=FONT_SIZE_SMALL;
            lbl_suppliersName_prefix.text=@"分单时间:";
            [self.contentView addSubview:lbl_suppliersName_prefix];
            
            [lbl_suppliersName_prefix mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_batchNo_prefix.mas_bottom);
                make.left.mas_equalTo(15);
                make.size.mas_equalTo(CGSizeMake(78, 24));
            }];
            
            lbl_suppliersName=[[UILabel alloc] init];
            lbl_suppliersName.textAlignment=NSTextAlignmentLeft;
            lbl_suppliersName.textColor=COLOR_BLACK;
            lbl_suppliersName.font=FONT_SIZE_SMALL;
            [self.contentView addSubview:lbl_suppliersName];
            
            [lbl_suppliersName mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.top.mas_equalTo(lbl_suppliersName_prefix.mas_top);
                make.left.mas_equalTo(lbl_suppliersName_prefix.mas_right).offset(2);
                make.right.mas_equalTo(self.mas_right).offset(-30);
                make.height.mas_equalTo(24);
            }];
        }

        if (lbl_editTime==nil) {
            lbl_editTime_prefix=[[UILabel alloc] init];
            lbl_editTime_prefix.textAlignment=NSTextAlignmentLeft;
            lbl_editTime_prefix.textColor=COLOR_BLACK;
            lbl_editTime_prefix.font=FONT_SIZE_SMALL;
            lbl_editTime_prefix.text=@"商品SKU:";
            [self.contentView addSubview:lbl_editTime_prefix];
            
            [lbl_editTime_prefix mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_suppliersName_prefix.mas_bottom);
                make.left.mas_equalTo(15);
                make.size.mas_equalTo(CGSizeMake(78, 24));
            }];
            
            lbl_editTime=[[UILabel alloc] init];
            lbl_editTime.textAlignment=NSTextAlignmentLeft;
            lbl_editTime.textColor=COLOR_BLACK;
            lbl_editTime.font=FONT_SIZE_SMALL;
            [self.contentView addSubview:lbl_editTime];
            
            [lbl_editTime mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.top.mas_equalTo(lbl_editTime_prefix.mas_top);
                make.left.mas_equalTo(lbl_editTime_prefix.mas_right).offset(2);
                make.right.mas_equalTo(self.mas_right).offset(-10);
                make.height.mas_equalTo(24);
            }];
            
        }
        
        if (lbl_needbind_prefix==nil) {
            lbl_needbind_prefix=[[UILabel alloc] init];
            lbl_needbind_prefix.textAlignment=NSTextAlignmentLeft;
            lbl_needbind_prefix.textColor=COLOR_BLACK;
            lbl_needbind_prefix.font=FONT_SIZE_SMALL;
            lbl_needbind_prefix.text=@"商品总数:";
            [self.contentView addSubview:lbl_needbind_prefix];
            
            [lbl_needbind_prefix mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_editTime_prefix.mas_bottom);
                make.left.mas_equalTo(15);
                make.size.mas_equalTo(CGSizeMake(78, 24));
            }];
            
            lbl_needbind=[[UILabel alloc] init];
            lbl_needbind.textAlignment=NSTextAlignmentLeft;
            lbl_needbind.textColor=COLOR_BLACK;
            lbl_needbind.font=FONT_SIZE_SMALL;
            [self.contentView addSubview:lbl_needbind];
            
            [lbl_needbind mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.top.mas_equalTo(lbl_needbind_prefix.mas_top);
                make.left.mas_equalTo(lbl_needbind_prefix.mas_right).offset(2);
                make.right.mas_equalTo(self.mas_right).offset(-10);
                make.height.mas_equalTo(24);
            }];
            
        }
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    lbl_batchNo.text=self.entity.order_sn;
    lbl_suppliersName.text=self.entity.create_time;
    lbl_editTime.text=self.entity.goods_sku;
    lbl_needbind.text=self.entity.goods_number;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
