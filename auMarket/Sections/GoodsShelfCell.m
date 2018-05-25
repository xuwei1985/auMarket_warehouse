//
//  PickOrderCell.m
//  auMarket
//
//  Created by 吴绪伟 on 2018/5/21.
//  Copyright © 2018 daao. All rights reserved.
//

#import "GoodsShelfCell.h"

@implementation GoodsShelfCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        @weakify(self);

        if (btn_select==nil) {
            btn_select=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn_select setImage:[UIImage imageNamed:@"add_transfer_off"] forState:UIControlStateNormal];
            [btn_select setImage:[UIImage imageNamed:@"add_transfer_on"] forState:UIControlStateSelected];
            [self.contentView addSubview:btn_select];
            
            [btn_select mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.bottom.mas_equalTo(self.mas_bottom).offset(-15);
                make.right.mas_equalTo(-15);
                make.size.mas_equalTo(CGSizeMake(28, 28));
            }];
        }
        
        if(!lbl_order_sn){
            @strongify(self);
            lbl_order_sn=[[UILabel alloc] init];
            lbl_order_sn.textColor=COLOR_DARKGRAY;
            lbl_order_sn.font=FONT_SIZE_SMALL;
            lbl_order_sn.text=@"货架号";
            [self.contentView addSubview:lbl_order_sn];
            
            [lbl_order_sn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(15);
                make.left.mas_equalTo(self.mas_left).offset(15);
                make.size.mas_equalTo(CGSizeMake(74, 20));
            }];
        }
        
        if(!lbl_order_sn_value){
            lbl_order_sn_value=[[UILabel alloc] init];
            lbl_order_sn_value.textColor=COLOR_BLACK;
            lbl_order_sn_value.font=FONT_SIZE_SMALL;
            lbl_order_sn_value.text=@"201834857";
            [self.contentView addSubview:lbl_order_sn_value];
            
            [lbl_order_sn_value mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(15);
                make.left.mas_equalTo(lbl_order_sn.mas_right);
                make.size.mas_equalTo(CGSizeMake(120, 20));
            }];
        }
        
        if(!lbl_order_region){
            @strongify(self);
            lbl_order_region=[[UILabel alloc] init];
            lbl_order_region.textColor=COLOR_DARKGRAY;
            lbl_order_region.font=FONT_SIZE_SMALL;
            lbl_order_region.text=@"保质期";
            [self.contentView addSubview:lbl_order_region];
            
            [lbl_order_region mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_order_sn.mas_bottom).offset(5);
                make.left.mas_equalTo(self.mas_left).offset(15);
                make.size.mas_equalTo(CGSizeMake(74, 20));
            }];
        }
        
        if(!lbl_order_region_value){
            lbl_order_region_value=[[UILabel alloc] init];
            lbl_order_region_value.textColor=COLOR_BLACK;
            lbl_order_region_value.font=FONT_SIZE_SMALL;
            lbl_order_region_value.text=@"2019.10.02";
            [self.contentView addSubview:lbl_order_region_value];
            
            [lbl_order_region_value mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_order_sn_value.mas_bottom).offset(5);
                make.left.mas_equalTo(lbl_order_region.mas_right);
                make.size.mas_equalTo(CGSizeMake(120, 20));
            }];
        }
        
        if(!lbl_order_price){
            @strongify(self);
            lbl_order_price=[[UILabel alloc] init];
            lbl_order_price.textColor=COLOR_DARKGRAY;
            lbl_order_price.font=FONT_SIZE_SMALL;
            lbl_order_price.text=@"录入时间";
            [self.contentView addSubview:lbl_order_price];
            
            [lbl_order_price mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_order_region.mas_bottom).offset(5);
                make.left.mas_equalTo(self.mas_left).offset(15);
                make.size.mas_equalTo(CGSizeMake(74, 20));
            }];
        }
        
        if(!lbl_order_price_value){
            lbl_order_price_value=[[UILabel alloc] init];
            lbl_order_price_value.textColor=COLOR_BLACK;
            lbl_order_price_value.font=FONT_SIZE_SMALL;
            lbl_order_price_value.text=@"2017-10-30";
            [self.contentView addSubview:lbl_order_price_value];
            
            [lbl_order_price_value mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_order_region_value.mas_bottom).offset(5);
                make.left.mas_equalTo(lbl_order_price.mas_right);
                make.size.mas_equalTo(CGSizeMake(120, 20));
            }];
        }
        
        if(!lbl_order_goods_num){
            @strongify(self);
            lbl_order_goods_num=[[UILabel alloc] init];
            lbl_order_goods_num.textColor=COLOR_DARKGRAY;
            lbl_order_goods_num.font=FONT_SIZE_SMALL;
            lbl_order_goods_num.text=@"数量";
            [self.contentView addSubview:lbl_order_goods_num];
            
            [lbl_order_goods_num mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_order_price.mas_bottom).offset(5);
                make.left.mas_equalTo(self.mas_left).offset(15);
                make.size.mas_equalTo(CGSizeMake(74, 20));
            }];
        }
        
        if(!lbl_order_goods_num_value){
            lbl_order_goods_num_value=[[UILabel alloc] init];
            lbl_order_goods_num_value.textColor=COLOR_BLACK;
            lbl_order_goods_num_value.font=FONT_SIZE_SMALL;
            lbl_order_goods_num_value.text=@"65";
            [self.contentView addSubview:lbl_order_goods_num_value];
            
            [lbl_order_goods_num_value mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_order_price_value.mas_bottom).offset(5);
                make.left.mas_equalTo(lbl_order_goods_num.mas_right);
                make.size.mas_equalTo(CGSizeMake(120, 20));
            }];
        }
        
        if(!lbl_bind_tip){
            @strongify(self);
            lbl_bind_tip=[[UILabel alloc] init];
            lbl_bind_tip.textColor=COLOR_DARKGRAY;
            lbl_bind_tip.font=FONT_SIZE_SMALL;
            lbl_bind_tip.text=@"待转移";
            [self.contentView addSubview:lbl_bind_tip];
            
            [lbl_bind_tip mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_order_goods_num.mas_bottom).offset(5);
                make.left.mas_equalTo(self.mas_left).offset(15);
                make.size.mas_equalTo(CGSizeMake(74, 18));
            }];
        }
        
        if(!lbl_bind_mark){
            @strongify(self);
            lbl_bind_mark=[[UILabel alloc] init];
            lbl_bind_mark.textColor=COLOR_MAIN;
            lbl_bind_mark.font=FONT_SIZE_SMALL;
            lbl_bind_mark.text=@"0";
            lbl_bind_mark.textAlignment=NSTextAlignmentLeft;
            [self.contentView addSubview:lbl_bind_mark];
            
            [lbl_bind_mark mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_order_goods_num_value.mas_bottom).offset(5);
                make.left.mas_equalTo(lbl_bind_tip.mas_right);
                make.size.mas_equalTo(CGSizeMake(100, 14));
            }];
        }
    }
    return self;
}


-(void)selOrder:(UIButton *)sender{
    sender.selected=!sender.selected;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
