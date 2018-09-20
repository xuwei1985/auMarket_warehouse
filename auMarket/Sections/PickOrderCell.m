//
//  PickOrderCell.m
//  auMarket
//
//  Created by 吴绪伟 on 2018/5/21.
//  Copyright © 2018 daao. All rights reserved.
//

#import "PickOrderCell.h"

@implementation PickOrderCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        @weakify(self);

        if (btn_select==nil) {
            btn_select=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn_select setImage:[UIImage imageNamed:@"sel_off"] forState:UIControlStateNormal];
            [btn_select setImage:[UIImage imageNamed:@"sel_on"] forState:UIControlStateSelected];
            [btn_select addTarget:self action:@selector(selOrder:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn_select];
            
            [btn_select mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.centerY.mas_equalTo(self.mas_centerY);
                make.left.mas_equalTo(10);
                make.size.mas_equalTo(CGSizeMake(20, 20));
            }];
        }
        
        if(!lbl_order_sn){
            lbl_order_sn=[[UILabel alloc] init];
            lbl_order_sn.textColor=COLOR_DARKGRAY;
            lbl_order_sn.font=FONT_SIZE_SMALL;
            lbl_order_sn.text=@"订单编号：";
            [self.contentView addSubview:lbl_order_sn];
            
            [lbl_order_sn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(15);
                make.left.mas_equalTo(btn_select.mas_right).offset(15);
                make.size.mas_equalTo(CGSizeMake(74, 20));
            }];
        }
        
        if(!lbl_order_sn_value){
            lbl_order_sn_value=[[UILabel alloc] init];
            lbl_order_sn_value.textColor=COLOR_DARKGRAY;
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
            lbl_order_region=[[UILabel alloc] init];
            lbl_order_region.textColor=COLOR_DARKGRAY;
            lbl_order_region.font=FONT_SIZE_SMALL;
            lbl_order_region.text=@"订单区域：";
            [self.contentView addSubview:lbl_order_region];
            
            [lbl_order_region mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_order_sn.mas_bottom).offset(4);
                make.left.mas_equalTo(btn_select.mas_right).offset(15);
                make.size.mas_equalTo(CGSizeMake(74, 20));
            }];
        }
        
        if(!lbl_order_region_value){
            lbl_order_region_value=[[UILabel alloc] init];
            lbl_order_region_value.textColor=COLOR_DARKGRAY;
            lbl_order_region_value.font=FONT_SIZE_SMALL;
            lbl_order_region_value.text=@"--";
            [self.contentView addSubview:lbl_order_region_value];
            
            [lbl_order_region_value mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_order_sn_value.mas_bottom).offset(4);
                make.left.mas_equalTo(lbl_order_region.mas_right);
                make.size.mas_equalTo(CGSizeMake(120, 20));
            }];
        }
        
        if(!lbl_order_price){
            lbl_order_price=[[UILabel alloc] init];
            lbl_order_price.textColor=COLOR_DARKGRAY;
            lbl_order_price.font=FONT_SIZE_SMALL;
            lbl_order_price.text=@"订单总价：";
            [self.contentView addSubview:lbl_order_price];
            
            [lbl_order_price mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_order_region.mas_bottom).offset(4);
                make.left.mas_equalTo(btn_select.mas_right).offset(15);
                make.size.mas_equalTo(CGSizeMake(74, 20));
            }];
        }
        
        if(!lbl_order_price_value){
            lbl_order_price_value=[[UILabel alloc] init];
            lbl_order_price_value.textColor=COLOR_MAIN;
            lbl_order_price_value.font=FONT_SIZE_SMALL;
            lbl_order_price_value.text=@"$0.00";
            [self.contentView addSubview:lbl_order_price_value];
            
            [lbl_order_price_value mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_order_region_value.mas_bottom).offset(4);
                make.left.mas_equalTo(lbl_order_price.mas_right);
                make.size.mas_equalTo(CGSizeMake(120, 20));
            }];
        }
        
        if(!lbl_order_goods_num){
            lbl_order_goods_num=[[UILabel alloc] init];
            lbl_order_goods_num.textColor=COLOR_DARKGRAY;
            lbl_order_goods_num.font=FONT_SIZE_SMALL;
            lbl_order_goods_num.text=@"商品总数：";
            [self.contentView addSubview:lbl_order_goods_num];
            
            [lbl_order_goods_num mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_order_price.mas_bottom).offset(4);
                make.left.mas_equalTo(btn_select.mas_right).offset(15);
                make.size.mas_equalTo(CGSizeMake(74, 20));
            }];
        }
        
        if(!lbl_order_goods_num_value){
            lbl_order_goods_num_value=[[UILabel alloc] init];
            lbl_order_goods_num_value.textColor=COLOR_DARKGRAY;
            lbl_order_goods_num_value.font=FONT_SIZE_SMALL;
            lbl_order_goods_num_value.text=@"0";
            [self.contentView addSubview:lbl_order_goods_num_value];
            
            [lbl_order_goods_num_value mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_order_price_value.mas_bottom).offset(4);
                make.left.mas_equalTo(lbl_order_goods_num.mas_right);
                make.size.mas_equalTo(CGSizeMake(150, 20));
            }];
        }
        
        if(!lbl_done_time){
            lbl_done_time=[[UILabel alloc] init];
            lbl_done_time.textColor=COLOR_DARKGRAY;
            lbl_done_time.font=FONT_SIZE_SMALL;
            lbl_done_time.text=@"完成时间：";
            lbl_done_time.hidden=YES;
            [self.contentView addSubview:lbl_done_time];
            
            [lbl_done_time mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_order_goods_num.mas_bottom).offset(4);
                make.left.mas_equalTo(btn_select.mas_right).offset(15);
                make.size.mas_equalTo(CGSizeMake(74, 20));
            }];
        }
        
        if(!lbl_done_time_value){
            lbl_done_time_value=[[UILabel alloc] init];
            lbl_done_time_value.textColor=COLOR_DARKGRAY;
            lbl_done_time_value.font=FONT_SIZE_SMALL;
            lbl_done_time_value.text=@"--";
            lbl_done_time_value.hidden=YES;
            [self.contentView addSubview:lbl_done_time_value];
            
            [lbl_done_time_value mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_order_goods_num_value.mas_bottom).offset(4);
                make.left.mas_equalTo(lbl_done_time.mas_right);
                make.size.mas_equalTo(CGSizeMake(150, 20));
            }];
        }
        
        if(!lbl_bind_tip){
            @strongify(self);
            lbl_bind_tip=[[UILabel alloc] init];
            lbl_bind_tip.textColor=COLOR_MAIN;
            lbl_bind_tip.font=FONT_SIZE_SMALL;
            lbl_bind_tip.text=@"待绑定拣货箱";
            [self.contentView addSubview:lbl_bind_tip];
            
            [lbl_bind_tip mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.mas_bottom).offset(-14);
                make.left.mas_equalTo(btn_select.mas_right).offset(15);
                make.size.mas_equalTo(CGSizeMake(90, 18));
            }];
        }
        
        if(!lbl_bind_mark){
            @strongify(self);
            lbl_bind_mark=[[UILabel alloc] init];
            lbl_bind_mark.textColor=COLOR_WHITE;
            lbl_bind_mark.backgroundColor=COLOR_MAIN;
            lbl_bind_mark.font=DEFAULT_FONT(10);
            lbl_bind_mark.text=@"";
            lbl_bind_mark.hidden=YES;
            lbl_bind_mark.textAlignment=NSTextAlignmentCenter;
            lbl_bind_mark.clipsToBounds=YES;
            lbl_bind_mark.layer.cornerRadius=7.0f;
            lbl_bind_mark.layer.borderColor = COLOR_WHITE.CGColor;
            [lbl_bind_mark.layer setBorderWidth:0.5];
            lbl_bind_mark.layer.shouldRasterize = YES;
            [self.contentView addSubview:lbl_bind_mark];
            
            [lbl_bind_mark mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.mas_bottom).offset(-17);
                make.right.mas_equalTo(self.mas_right).offset(-15);
                make.size.mas_equalTo(CGSizeMake(14, 14));
            }];
        }
        
        if(!btn_type_freeze){
            btn_type_freeze = [[UIButton alloc] init];
            [btn_type_freeze setTitle:@"冷冻" forState:UIControlStateNormal];
            [btn_type_freeze setImage:[UIImage imageNamed:@"s_f"] forState:UIWindowLevelNormal];
            btn_type_freeze.titleLabel.font = DEFAULT_FONT(12);
            [btn_type_freeze setTitleColor:COLOR_DARKGRAY forState:UIControlStateNormal];
            btn_type_freeze.showsTouchWhenHighlighted = YES;
            btn_type_freeze.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            btn_type_freeze.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            btn_type_freeze.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
            btn_type_freeze.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [self.contentView addSubview:btn_type_freeze];
            
            [btn_type_freeze mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(lbl_bind_tip.mas_top).offset(0);
                make.left.mas_equalTo(btn_select.mas_right).offset(15);
                make.size.mas_equalTo(CGSizeMake(60, 32));
            }];
        }
        
        if(!btn_type_zero){
            btn_type_zero = [[UIButton alloc] init];
            [btn_type_zero setTitle:@"冷藏" forState:UIControlStateNormal];
            [btn_type_zero setImage:[UIImage imageNamed:@"s_d"] forState:UIWindowLevelNormal];
            btn_type_zero.titleLabel.font = DEFAULT_FONT(12);
            [btn_type_zero setTitleColor:COLOR_DARKGRAY forState:UIControlStateNormal];
            btn_type_zero.showsTouchWhenHighlighted = YES;
            btn_type_zero.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            btn_type_zero.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            btn_type_zero.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
            btn_type_zero.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [self.contentView addSubview:btn_type_zero];
            
            [btn_type_zero mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(lbl_bind_tip.mas_top).offset(0);
                make.left.mas_equalTo(btn_type_freeze.mas_right).offset(5);
                make.size.mas_equalTo(CGSizeMake(60, 32));
            }];
        }
        
        if(!btn_type_box){
            btn_type_box = [[UIButton alloc] init];
            [btn_type_box setTitle:@"整箱" forState:UIControlStateNormal];
            [btn_type_box setImage:[UIImage imageNamed:@"s_b"] forState:UIWindowLevelNormal];
            btn_type_box.titleLabel.font = DEFAULT_FONT(12);
            [btn_type_box setTitleColor:COLOR_DARKGRAY forState:UIControlStateNormal];
            btn_type_box.showsTouchWhenHighlighted = YES;
            btn_type_box.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            btn_type_box.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            btn_type_box.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
            btn_type_box.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [self.contentView addSubview:btn_type_box];
            
            [btn_type_box mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(lbl_bind_tip.mas_top).offset(0);
                make.left.mas_equalTo(btn_type_zero.mas_right).offset(5);
                make.size.mas_equalTo(CGSizeMake(60, 32));
            }];
        }
    }
    return self;
}


-(void)selOrder:(UIButton *)sender{
    if(self.entity.box!=nil&&[self.entity.box length]>0){
        sender.selected=!sender.selected;
        self.entity.selected=sender.selected;
        if(self.entity.selected){
            self.selOrderBlock(self.entity.order_id,1);//选中
        }
        else{
            self.selOrderBlock(self.entity.order_id,0);//取消
        }
    }
    else{
        sender.selected=NO;
        self.selOrderBlock(self.entity.order_id,-1);//禁止
    }
}

-(void)selOrderId:(SelOrderBlock)block
{
    self.selOrderBlock = block;
}

-(void)toggleOrderSel{
    if(self.entity.box!=nil&&[self.entity.box length]>0){
        self.entity.selected=!self.entity.selected;
        if(self.entity.selected){
            self.selOrderBlock(self.entity.order_id,1);//选中
        }
        else{
            self.selOrderBlock(self.entity.order_id,0);//取消
        }
    }
    else{
        self.selOrderBlock(self.entity.order_id,-1);//禁止
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if(self.list_model==1){
        [btn_select mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
    lbl_order_sn_value.text=self.entity.order_sn;
    lbl_order_region_value.text=self.entity.region_name;
    lbl_order_goods_num_value.text=self.entity.goods_count;
    lbl_order_price_value.text=[NSString stringWithFormat:@"$%@",self.entity.total_price];
    
    if(self.list_model==1){
        lbl_done_time.hidden=NO;
        lbl_done_time_value.hidden=NO;
        lbl_done_time_value.text=self.entity.end_time;
    }
    else{
        lbl_done_time.hidden=YES;
        lbl_done_time_value.hidden=YES;
    }
    
    btn_type_freeze.hidden=[self.entity.attribute.frozen intValue]<=0;//冷冻
    btn_type_zero.hidden=[self.entity.attribute.cold intValue]<=0;//冷藏
    btn_type_box.hidden=[self.entity.attribute.package intValue]<=0;//整箱
    
    
    if(btn_type_freeze.hidden){
        if(!btn_type_zero.isHidden){
            [btn_type_zero mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(lbl_bind_tip.mas_top).offset(0);
                make.left.mas_equalTo(lbl_order_goods_num.mas_left);
                make.size.mas_equalTo(CGSizeMake(60, 32));
            }];
        }
    }
    else{
        if(!btn_type_zero.isHidden){
            [btn_type_zero mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(lbl_bind_tip.mas_top).offset(0);
                make.left.mas_equalTo(btn_type_freeze.mas_right).offset(5);
                make.size.mas_equalTo(CGSizeMake(60, 32));
            }];
        }
    }
    
    if(btn_type_zero.hidden){
        if(btn_type_freeze.hidden){
            if(!btn_type_box.isHidden){
                [btn_type_box mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(lbl_bind_tip.mas_top).offset(0);
                    make.left.mas_equalTo(lbl_order_goods_num.mas_left);
                    make.width.mas_equalTo(CGSizeMake(60, 32));
                }];
            }
        }
        else{
            if(!btn_type_box.isHidden){
                [btn_type_box mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(lbl_bind_tip.mas_top).offset(0);
                    make.left.mas_equalTo(btn_type_freeze.mas_right).offset(5);
                    make.size.mas_equalTo(CGSizeMake(60, 32));
                }];
            }
        }
    }
    else{
        if(!btn_type_box.isHidden){
            [btn_type_box mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(lbl_bind_tip.mas_top).offset(0);
                make.left.mas_equalTo(btn_type_freeze.mas_right).offset(5);
                make.size.mas_equalTo(CGSizeMake(60, 32));
            }];
        }
    }
    
    btn_select.selected=self.entity.selected;
    
    if(self.entity.box&&[self.entity.box length]>0){
        NSRange range = [self.entity.box rangeOfString:@"-"];
        if(range.location != NSNotFound){
             lbl_bind_tip.text=[NSString stringWithFormat:@"拣货箱：%@",[self.entity.box substringToIndex:range.location]];
             lbl_bind_mark.backgroundColor=[Common hexColor:[self.entity.box substringFromIndex:range.location+1]];
             lbl_bind_mark.text=@"";
             lbl_bind_mark.hidden=NO;
        }
        else{
             lbl_bind_tip.text=[NSString stringWithFormat:@"拣货箱：invalid"];
             lbl_bind_mark.hidden=YES;
        }
        lbl_bind_tip.textColor=COLOR_DARKGRAY;
    }
    else{
        lbl_bind_tip.text=@"待绑定拣货箱";
        lbl_bind_tip.textColor=COLOR_MAIN;
        lbl_bind_mark.backgroundColor=COLOR_MAIN;
        lbl_bind_mark.hidden=YES;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
