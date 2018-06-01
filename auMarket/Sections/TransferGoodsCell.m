//
//  TransferShelfCell.m
//  auMarket
//
//  Created by 吴绪伟 on 2018/5/21.
//  Copyright © 2018 daao. All rights reserved.
//

#import "TransferGoodsCell.h"

@implementation TransferGoodsCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        @weakify(self);

        if (btn_select==nil) {
            btn_select=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn_select setImage:[UIImage imageNamed:@"sel_off"] forState:UIControlStateNormal];
            [btn_select setImage:[UIImage imageNamed:@"sel_on"] forState:UIControlStateSelected];
            [btn_select addTarget:self action:@selector(selectStackGoods:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn_select];
            
            [btn_select mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.centerY.mas_equalTo(self.mas_centerY);
                make.left.mas_equalTo(10);
                make.size.mas_equalTo(CGSizeMake(20, 20));
            }];
        }
        
        if (img_goods==nil) {
            img_goods=[[UIImageView alloc] init];
            img_goods.image=[UIImage imageNamed:@"defaut_list"];
            [self.contentView addSubview:img_goods];
            
            [img_goods mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(15);
                make.left.mas_equalTo(btn_select.mas_right).offset(10);
                make.size.mas_equalTo(CGSizeMake(84,84));
            }];
        }
        
        if(!lbl_goods_name_value){
            @strongify(self);
            lbl_goods_name_value=[[UILabel alloc] init];
            lbl_goods_name_value.textColor=COLOR_BLACK;
            lbl_goods_name_value.font=FONT_SIZE_SMALL;
            lbl_goods_name_value.text=@"";
            lbl_goods_name_value.numberOfLines=2;
            lbl_goods_name_value.lineBreakMode=NSLineBreakByWordWrapping;
            lbl_goods_name_value.textAlignment=NSTextAlignmentLeft;
            [self.contentView addSubview:lbl_goods_name_value];
            
            [lbl_goods_name_value mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(15);
                make.left.mas_equalTo(img_goods.mas_right).offset(10);
                make.right.mas_equalTo(self.mas_right).offset(-10);
            }];
        }
        if(!lbl_goods_num){
            @strongify(self);
            lbl_goods_num=[[UILabel alloc] init];
            lbl_goods_num.textColor=COLOR_DARKGRAY;
            lbl_goods_num.font=FONT_SIZE_SMALL;
            lbl_goods_num.text=@"数量：";
            [self.contentView addSubview:lbl_goods_num];
            
            [lbl_goods_num mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_goods_name_value.mas_bottom).offset(8);
                make.left.mas_equalTo(img_goods.mas_right).offset(10);
                make.size.mas_equalTo(CGSizeMake(60, 20));
            }];
        }
        
        if(!lbl_goods_num_value){
            @strongify(self);
            lbl_goods_num_value=[[UILabel alloc] init];
            lbl_goods_num_value.textColor=COLOR_BLACK;
            lbl_goods_num_value.font=FONT_SIZE_SMALL;
            lbl_goods_num_value.text=@"0";
            [self.contentView addSubview:lbl_goods_num_value];
            
            [lbl_goods_num_value mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_goods_num.mas_top);
                make.left.mas_equalTo(lbl_goods_num.mas_right);
                make.right.mas_equalTo(self.mas_right).offset(-10);
                make.height.mas_equalTo(20);
            }];
        }
        
        if(!lbl_shelf_old){
            @strongify(self);
            lbl_shelf_old=[[UILabel alloc] init];
            lbl_shelf_old.textColor=COLOR_DARKGRAY;
            lbl_shelf_old.font=FONT_SIZE_SMALL;
            lbl_shelf_old.text=@"原货架：";
            [self.contentView addSubview:lbl_shelf_old];
            
            [lbl_shelf_old mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_goods_num.mas_bottom).offset(0);
                make.left.mas_equalTo(img_goods.mas_right).offset(10);
                make.size.mas_equalTo(CGSizeMake(60, 20));
            }];
        }
        
        if(!lbl_shelf_old_value){
            @strongify(self);
            lbl_shelf_old_value=[[UILabel alloc] init];
            lbl_shelf_old_value.textColor=COLOR_BLACK;
            lbl_shelf_old_value.font=FONT_SIZE_SMALL;
            lbl_shelf_old_value.text=@"--";
            [self.contentView addSubview:lbl_shelf_old_value];
            
            [lbl_shelf_old_value mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_shelf_old.mas_top);
                make.left.mas_equalTo(lbl_shelf_old.mas_right);
                make.right.mas_equalTo(self.mas_right).offset(-10);
                make.height.mas_equalTo(20);
            }];
        }
        
        if(!lbl_shelf_new){
            @strongify(self);
            lbl_shelf_new=[[UILabel alloc] init];
            lbl_shelf_new.textColor=COLOR_DARKGRAY;
            lbl_shelf_new.font=FONT_SIZE_SMALL;
            lbl_shelf_new.text=@"新货架：";
            [self.contentView addSubview:lbl_shelf_new];
            
            [lbl_shelf_new mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_shelf_old.mas_bottom).offset(0);
                make.left.mas_equalTo(img_goods.mas_right).offset(10);
                make.size.mas_equalTo(CGSizeMake(60, 20));
            }];
        }
        
        if(!lbl_shelf_new_value){
            @strongify(self);
            lbl_shelf_new_value=[[UILabel alloc] init];
            lbl_shelf_new_value.textColor=COLOR_BLACK;
            lbl_shelf_new_value.font=FONT_SIZE_SMALL;
            lbl_shelf_new_value.text=@"--";
            [self.contentView addSubview:lbl_shelf_new_value];
            
            [lbl_shelf_new_value mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lbl_shelf_new.mas_top);
                make.left.mas_equalTo(lbl_shelf_new.mas_right);
                make.right.mas_equalTo(self.mas_right).offset(-10);
                make.height.mas_equalTo(20);
            }];
        }
    }
    return self;
}

-(void)selectStackGoods:(UIButton *)sender{
    if(self.selStackGoodsBlock){
        
        if(self.entity.target_shelves!=nil&&[self.entity.target_shelves length]>0){
            sender.selected=!sender.selected;
            self.entity.selected=sender.selected;
            if(self.entity.selected){
                self.selStackGoodsBlock(self.entity.id,1);//选中
            }
            else{
                self.selStackGoodsBlock(self.entity.id,0);//取消
            }
        }
        else{
            sender.selected=NO;
            self.selStackGoodsBlock(self.entity.id,-1);//禁止
        }
    }
}

-(void)selStackGoods:(SelStackGoodsBlock)block{
    self.selStackGoodsBlock = block;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if(self.cell_model==1){
        [btn_select mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
    lbl_goods_name_value.text=self.entity.goods_name;
    [lbl_goods_name_value sizeToFit];
    
    
    lbl_goods_num_value.text=self.entity.number;
    lbl_shelf_old_value.text=self.entity.old_shelves;
    lbl_shelf_new_value.text=self.entity.target_shelves;
    
    [img_goods sd_setImageWithURL:[NSURL URLWithString:self.entity.goods_thumb] placeholderImage:[UIImage imageNamed:@"defaut_list"]];
    btn_select.selected=self.entity.selected;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
