//
//  MemberCell.m
//  XiaoYa
//
//  Created by XuWei on 15/1/3.
//  Copyright (c) 2015年 xuwei. All rights reserved.
//

#import "BatchCell.h"

@implementation BatchCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        @weakify(self);
        if (imv_addGoods==nil) {
            imv_addGoods=[[UIImageView alloc] init];
            imv_addGoods.image=[UIImage imageNamed:@"batch_add"];
            [self.contentView addSubview:imv_addGoods];
            
            [imv_addGoods mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.centerY.mas_equalTo(self.mas_centerY);
                make.right.mas_equalTo(-10);
                make.size.mas_equalTo(CGSizeMake(25, 25));
            }];
        }
        
        if (lbl_batchNo==nil) {
            lbl_batchNo_prefix=[[UILabel alloc] init];
            lbl_batchNo_prefix.textAlignment=NSTextAlignmentLeft;
            lbl_batchNo_prefix.textColor=COLOR_BLACK;
            lbl_batchNo_prefix.font=FONT_SIZE_MIDDLE;
            lbl_batchNo_prefix.text=@"批次号:";
            [self.contentView addSubview:lbl_batchNo_prefix];
            
            [lbl_batchNo_prefix mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(12);
                make.left.mas_equalTo(15);
                make.size.mas_equalTo(CGSizeMake(68, 24));
            }];
            
            lbl_batchNo=[[UILabel alloc] init];
            lbl_batchNo.textAlignment=NSTextAlignmentLeft;
            lbl_batchNo.textColor=COLOR_BLACK;
            lbl_batchNo.font=FONT_SIZE_MIDDLE;
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
            lbl_suppliersName_prefix.font=FONT_SIZE_MIDDLE;
            lbl_suppliersName_prefix.text=@"供应商:";
            [self.contentView addSubview:lbl_suppliersName_prefix];
            
            [lbl_suppliersName_prefix mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_batchNo_prefix.mas_bottom);
                make.left.mas_equalTo(15);
                make.size.mas_equalTo(CGSizeMake(68, 24));
            }];
            
            lbl_suppliersName=[[UILabel alloc] init];
            lbl_suppliersName.textAlignment=NSTextAlignmentLeft;
            lbl_suppliersName.textColor=COLOR_BLACK;
            lbl_suppliersName.font=FONT_SIZE_MIDDLE;
            [self.contentView addSubview:lbl_suppliersName];
            
            [lbl_suppliersName mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.top.mas_equalTo(lbl_suppliersName_prefix.mas_top);
                make.left.mas_equalTo(lbl_suppliersName_prefix.mas_right).offset(2);
                make.right.mas_equalTo(self.mas_right).offset(-10);
                make.height.mas_equalTo(24);
            }];
        }

        if (lbl_editTime==nil) {
            lbl_editTime_prefix=[[UILabel alloc] init];
            lbl_editTime_prefix.textAlignment=NSTextAlignmentLeft;
            lbl_editTime_prefix.textColor=COLOR_BLACK;
            lbl_editTime_prefix.font=FONT_SIZE_MIDDLE;
            lbl_editTime_prefix.text=@"最后修改:";
            [self.contentView addSubview:lbl_editTime_prefix];
            
            [lbl_editTime_prefix mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_suppliersName_prefix.mas_bottom);
                make.left.mas_equalTo(15);
                make.size.mas_equalTo(CGSizeMake(68, 24));
            }];
            
            lbl_editTime=[[UILabel alloc] init];
            lbl_editTime.textAlignment=NSTextAlignmentLeft;
            lbl_editTime.textColor=COLOR_MAIN;
            lbl_editTime.font=FONT_SIZE_MIDDLE;
            [self.contentView addSubview:lbl_editTime];
            
            [lbl_editTime mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.top.mas_equalTo(lbl_editTime_prefix.mas_top);
                make.left.mas_equalTo(lbl_editTime_prefix.mas_right).offset(2);
                make.right.mas_equalTo(self.mas_right).offset(-10);
                make.height.mas_equalTo(24);
            }];
            
        }
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    lbl_batchNo.text=self.entity.batch_no;
    lbl_suppliersName.text=self.entity.suppliers_name;
    lbl_editTime.text=self.entity.created_at;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
