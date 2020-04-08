//
//  GoodsCategoryParentCell.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/13.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "OrderItemCell.h"

@implementation OrderItemCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.backgroundColor=COLOR_BG_TABLEVIEWCELL;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    @weakify(self);
    
    _orderSnTitleLbl=[[UILabel alloc] init];
    _orderSnTitleLbl.text=@"订单号:";
    _orderSnTitleLbl.font=DEFAULT_FONT(14.0);
    _orderSnTitleLbl.textColor=COLOR_BLACK;
    _orderSnTitleLbl.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_orderSnTitleLbl];
    
    [_orderSnTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.mas_equalTo(self.mas_top).offset(16);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
    
    _orderSnValueLbl=[[UILabel alloc] init];
    _orderSnValueLbl.text=@"";
    _orderSnValueLbl.font=DEFAULT_BOLD_FONT(14.0);
    _orderSnValueLbl.textColor=COLOR_DARKGRAY;
    _orderSnValueLbl.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_orderSnValueLbl];
    
    [_orderSnValueLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_orderSnTitleLbl.mas_top);
        make.left.mas_equalTo(_orderSnTitleLbl.mas_right);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(-65);
    }];
    
    _orderPriceTitleLbl=[[UILabel alloc] init];
    _orderPriceTitleLbl.text=@"配送时间:";
    _orderPriceTitleLbl.font=DEFAULT_FONT(14.0);
    _orderPriceTitleLbl.textColor=COLOR_BLACK;
    _orderPriceTitleLbl.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_orderPriceTitleLbl];
    
    [_orderPriceTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_orderSnTitleLbl.mas_bottom).offset(9);
        make.left.mas_equalTo(_orderSnTitleLbl.mas_left);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
    
    _orderPriceValueLbl=[[UILabel alloc] init];
    _orderPriceValueLbl.text=@"--";
    _orderPriceValueLbl.font=DEFAULT_FONT(14.0);
    _orderPriceValueLbl.textColor=COLOR_DARKGRAY;
    _orderPriceValueLbl.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_orderPriceValueLbl];
    
    [_orderPriceValueLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_orderSnTitleLbl.mas_bottom).offset(9);
        make.left.mas_equalTo(_orderPriceTitleLbl.mas_right);
        make.right.mas_equalTo(WIDTH_SCREEN-90);
        make.height.mas_equalTo(20);
    }];

}

-(void)loadData{
    _orderSnValueLbl.text=[NSString stringWithFormat:@"%@",self.entity.order_sn];
    _orderPriceValueLbl.text=[NSString stringWithFormat:@"%@",self.entity.receiving_time];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    [self loadData];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
