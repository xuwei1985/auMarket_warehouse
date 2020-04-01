//
//  MemberCell.m
//  XiaoYa
//
//  Created by XuWei on 15/1/3.
//  Copyright (c) 2015年 xuwei. All rights reserved.
//

#import "BatchPickGoodsCell.h"

@implementation BatchPickGoodsCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        @weakify(self);
        
        if (_iconImageView==nil) {
            _iconImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 84, 84)];
            _iconImageView.image=[UIImage imageNamed:@"defaut_list"];
            [self.contentView addSubview:_iconImageView];
        }
        if (_itemLbl==nil) {
            _itemLbl=[[UILabel alloc] init];
            _itemLbl.textAlignment=NSTextAlignmentLeft;
            _itemLbl.textColor=COLOR_BLACK;
            _itemLbl.font=DEFAULT_FONT(14.0);
            _itemLbl.numberOfLines=2;
            _itemLbl.lineBreakMode=NSLineBreakByWordWrapping;
            [self.contentView addSubview:_itemLbl];
            
            [_itemLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.top.mas_equalTo(self.mas_top).offset(10);
                make.left.mas_equalTo(_iconImageView.mas_right).offset(10);
                make.right.mas_equalTo(self.mas_right).offset(-10);
            }];
        }
        
        if (_priceLbl==nil) {
            _priceLbl=[[UILabel alloc] init];
            _priceLbl.textAlignment=NSTextAlignmentLeft;
            _priceLbl.textColor=COLOR_GRAY;
            _priceLbl.font=FONT_SIZE_SMALL;
            [self.contentView addSubview:_priceLbl];
            
            [_priceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_itemLbl.mas_bottom).offset(5);
                make.left.mas_equalTo(_iconImageView.mas_right).offset(10);
                make.size.mas_equalTo(CGSizeMake(100, 20));
            }];
        }
        
        if (_totalPriceLbl==nil) {
            _totalPriceLbl=[[UILabel alloc] init];
            _totalPriceLbl.textAlignment=NSTextAlignmentLeft;
            _totalPriceLbl.textColor=COLOR_MAIN;
            _totalPriceLbl.font=[UIFont boldSystemFontOfSize:13];
            [self.contentView addSubview:_totalPriceLbl];
            
            [_totalPriceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-12);
                make.left.mas_equalTo(_iconImageView.mas_right).offset(10);
                make.size.mas_equalTo(CGSizeMake(120, 20));
            }];
        }
        
        
        if (_shelf_no==nil) {
            _shelf_no=[[UILabel alloc] init];
            _shelf_no.textAlignment=NSTextAlignmentCenter;
            _shelf_no.textColor=COLOR_WHITE;
            _shelf_no.font=[UIFont systemFontOfSize:13];
            _shelf_no.backgroundColor=[UIColor colorWithString:@"#5BA2EE"];
            _shelf_no.layer.cornerRadius=10;
            _shelf_no.clipsToBounds=YES;
            [self.contentView addSubview:_shelf_no];
            
            [_shelf_no mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-12);
                make.right.mas_equalTo(-8);
                make.size.mas_equalTo(CGSizeMake(70, 20));
            }];
        }
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:self.entity.goods_thumb] placeholderImage:[UIImage imageNamed:@"defaut_list"]];
    
    if(self.entity.goods_name==nil||self.entity.goods_name.length<=0){
        _itemLbl.text=@"未命名商品";
    }
    else{
        _itemLbl.text=self.entity.goods_name;
    }

    if(self.entity.shelves_code==nil||[self.entity.shelves_code length]<=0)
    {
        _shelf_no.text=@"无货架";
    }
    else{
        _shelf_no.text=self.entity.shelves_code;
    }
    
    _priceLbl.text=[NSString stringWithFormat:@"库存：%@",self.entity.inventory];
    _totalPriceLbl.text=[NSString stringWithFormat:@"拣货:%@",self.entity.goods_number];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
