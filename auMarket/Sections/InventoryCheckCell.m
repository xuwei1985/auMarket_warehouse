//
//  PickOrderCell.m
//  auMarket
//
//  Created by 吴绪伟 on 2018/5/21.
//  Copyright © 2018 daao. All rights reserved.
//

#import "InventoryCheckCell.h"

@implementation InventoryCheckCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        @weakify(self);

        if (btn_select==nil) {
            btn_select=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn_select setImage:[UIImage imageNamed:@"add_transfer_off"] forState:UIControlStateNormal];
            [btn_select setImage:[UIImage imageNamed:@"add_transfer_on"] forState:UIControlStateSelected];
            [btn_select addTarget:self action:@selector(addToStack:) forControlEvents:UIControlEventTouchUpInside];
            btn_select.hidden=YES;
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
            lbl_order_sn_value.text=@"--";
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
            lbl_order_region_value.text=@"--";
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
            lbl_order_price_value.text=@"--";
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
            lbl_order_goods_num_value.text=@"0";
            [self.contentView addSubview:lbl_order_goods_num_value];
            
            [lbl_order_goods_num_value mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_order_price_value.mas_bottom).offset(5);
                make.left.mas_equalTo(lbl_order_goods_num.mas_right);
                make.size.mas_equalTo(CGSizeMake(150, 20));
            }];
        }
        
        
        if(!lbl_bind_tip){
            @strongify(self);
            lbl_bind_tip=[[UILabel alloc] init];
            lbl_bind_tip.textColor=COLOR_DARKGRAY;
            lbl_bind_tip.font=FONT_SIZE_SMALL;
            lbl_bind_tip.text=@"待转移";
            lbl_bind_tip.hidden=YES;
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
            lbl_bind_mark.hidden=YES;
            [self.contentView addSubview:lbl_bind_mark];
            
            [lbl_bind_mark mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_order_goods_num_value.mas_bottom).offset(5);
                make.left.mas_equalTo(lbl_bind_tip.mas_right);
                make.size.mas_equalTo(CGSizeMake(100, 18));
            }];
        }
    }
    return self;
}


-(void)addToStack:(UIButton *)sender{
    self.addStackBlock(self.entity);
}

-(void)addStack:(AddStackBlock)block{
    self.addStackBlock = block;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if([self.entity.transfer_number intValue]>0){
        btn_select.selected=YES;
    }
    else{
        btn_select.selected=NO;
    }
    lbl_bind_mark.text=[NSString  stringWithFormat:@"%d",[self.entity.transfer_number intValue]];
    
    
    lbl_order_region_value.text=self.entity.expired_date;
    lbl_order_price_value.text=self.entity.created_at;
    lbl_order_goods_num_value.text=[NSString stringWithFormat:@"%d (未拣货:%@)",([self.entity.inventory intValue]-[self.entity.move_number intValue]),self.entity.number];
    
    if([self.entity.storage intValue]==1){
        lbl_order_sn_value.textColor=[Common hexColor:@"#0092FF"];
        lbl_order_sn_value.text=[NSString stringWithFormat:@"%@ (储)",self.entity.shelves_code];
    }
    else{
        lbl_order_sn_value.text=self.entity.shelves_code;
        lbl_order_sn_value.textColor=COLOR_DARKGRAY;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
