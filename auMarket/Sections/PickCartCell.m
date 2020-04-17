//
//  MemberCell.m
//  XiaoYa
//
//  Created by XuWei on 15/1/3.
//  Copyright (c) 2015年 xuwei. All rights reserved.
//

#import "PickCartCell.h"

@implementation PickCartCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        @weakify(self);
        
        UILabel *lbl_title=[[UILabel alloc] init];
        
        
        if (lbl_cart_name==nil) {
            lbl_title=[[UILabel alloc] init];
            lbl_title.textAlignment=NSTextAlignmentLeft;
            lbl_title.textColor=COLOR_DARKGRAY;
            lbl_title.font=FONT_SIZE_SMALL;
            lbl_title.text=@"拣货车号:";
            [self.contentView addSubview:lbl_title];
            
            [lbl_title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(12);
                make.left.mas_equalTo(10);
                make.size.mas_equalTo(CGSizeMake(68, 22));
            }];
            
            lbl_cart_name=[[UILabel alloc] init];
            lbl_cart_name.textAlignment=NSTextAlignmentLeft;
            lbl_cart_name.textColor=COLOR_MAIN;
            lbl_cart_name.font=[UIFont boldSystemFontOfSize:15];
            [self.contentView addSubview:lbl_cart_name];
            
            [lbl_cart_name mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.top.mas_equalTo(12);
                make.left.mas_equalTo(lbl_title.mas_right);
                make.right.mas_equalTo(self.mas_right).offset(-10);
                make.height.mas_equalTo(22);
            }];
        }

        if (lbl_order_num==nil) {
            lbl_title=[[UILabel alloc] init];
            lbl_title.textAlignment=NSTextAlignmentLeft;
            lbl_title.textColor=COLOR_DARKGRAY;
            lbl_title.font=FONT_SIZE_SMALL;
            lbl_title.text=@"订单数量:";
            [self.contentView addSubview:lbl_title];
            
            [lbl_title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_cart_name.mas_bottom).offset(2);
                make.left.mas_equalTo(10);
                make.size.mas_equalTo(CGSizeMake(68, 22));
            }];
            
            lbl_order_num=[[UILabel alloc] init];
            lbl_order_num.textAlignment=NSTextAlignmentLeft;
            lbl_order_num.textColor=COLOR_BLACK;
            lbl_order_num.font=FONT_SIZE_SMALL;
            [self.contentView addSubview:lbl_order_num];
            
            [lbl_order_num mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_cart_name.mas_bottom).offset(2);
                make.left.mas_equalTo(lbl_title.mas_right);
                make.size.mas_equalTo(CGSizeMake(60, 22));
            }];
        }
        
        if (lbl_dispatch_time==nil) {
            lbl_title=[[UILabel alloc] init];
            lbl_title.textAlignment=NSTextAlignmentLeft;
            lbl_title.textColor=COLOR_DARKGRAY;
            lbl_title.font=FONT_SIZE_SMALL;
            lbl_title.text=@"分派时间:";
            [self.contentView addSubview:lbl_title];
            
            [lbl_title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_order_num.mas_bottom).offset(2);
                make.left.mas_equalTo(10);
                make.size.mas_equalTo(CGSizeMake(68, 22));
            }];
            
            lbl_dispatch_time=[[UILabel alloc] init];
            lbl_dispatch_time.textAlignment=NSTextAlignmentLeft;
            lbl_dispatch_time.textColor=COLOR_BLACK;
            lbl_dispatch_time.font=FONT_SIZE_SMALL;
            [self.contentView addSubview:lbl_dispatch_time];
            
            [lbl_dispatch_time mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_order_num.mas_bottom).offset(2);
                make.left.mas_equalTo(lbl_title.mas_right);
                make.size.mas_equalTo(CGSizeMake(150, 22));
            }];
        }

        if (lbl_block==nil) {
            lbl_title=[[UILabel alloc] init];
            lbl_title.textAlignment=NSTextAlignmentLeft;
            lbl_title.textColor=COLOR_DARKGRAY;
            lbl_title.font=FONT_SIZE_SMALL;
            lbl_title.text=@"当前区域:";
            [self.contentView addSubview:lbl_title];
            
            [lbl_title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_dispatch_time.mas_bottom).offset(2);
                make.left.mas_equalTo(10);
                make.size.mas_equalTo(CGSizeMake(68, 22));
            }];
            
            lbl_block=[[UILabel alloc] init];
            lbl_block.textAlignment=NSTextAlignmentLeft;
            lbl_block.textColor=COLOR_BLACK;
            lbl_block.font=FONT_SIZE_SMALL;
            [self.contentView addSubview:lbl_block];
            
            [lbl_block mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_dispatch_time.mas_bottom).offset(2);
                make.left.mas_equalTo(lbl_title.mas_right);
                make.size.mas_equalTo(CGSizeMake(150, 22));
            }];
        }
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    lbl_cart_name.text=[NSString stringWithFormat:@"%@号车",self.entity.cart_num];
    lbl_order_num.text=[NSString stringWithFormat:@"%@单",self.entity.order_num];
    
    if(![self.entity.create_time isEqualToString:@""]){
        lbl_dispatch_time.text=[NSString stringWithFormat:@"%@",self.entity.create_time];
    }else{
        lbl_dispatch_time.text=[NSString stringWithFormat:@"--"];
    }
    if(![self.entity.current_block isEqualToString:@""]&&self.entity.current_block!=nil){
        lbl_block.text=[NSString stringWithFormat:@"%@区",self.entity.current_block];
    }else{
        lbl_block.text=[NSString stringWithFormat:@"--"];
    }
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
