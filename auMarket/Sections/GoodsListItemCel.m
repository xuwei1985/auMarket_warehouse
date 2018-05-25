//
//  GoodsCategoryParentCell.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/13.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "GoodsListItemCell.h"

@implementation GoodsListItemCell
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

    _goodsImageView=[[UIImageView alloc] init];
    _goodsImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_goodsImageView];

    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(6);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-6);
        make.width.mas_equalTo(self.mas_height);
    }];
    
    _goodsTitleLbl=[[UILabel alloc] init];
    _goodsTitleLbl.text=@"";
    _goodsTitleLbl.font=DEFAULT_FONT(14.0);
    _goodsTitleLbl.numberOfLines=2;
    _goodsTitleLbl.lineBreakMode=NSLineBreakByWordWrapping;
    _goodsTitleLbl.textColor=COLOR_FONT_BLACK;
    _goodsTitleLbl.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_goodsTitleLbl];
    
    [_goodsTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.mas_equalTo(self.mas_top).offset(12);
        make.left.mas_equalTo(_goodsImageView.mas_right).offset(12);
        make.right.mas_equalTo(self.mas_right).offset(-10);
    }];
    
    
    _goodsPriceLbl=[[UILabel alloc] init];
    _goodsPriceLbl.text=@"$0.0";
    _goodsPriceLbl.font=DEFAULT_BOLD_FONT(14.0);
    _goodsPriceLbl.textColor=COLOR_FONT_GOODS_PRICE;
    _goodsPriceLbl.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_goodsPriceLbl];
    
    [_goodsPriceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-8);
        make.left.mas_equalTo(_goodsImageView.mas_right).offset(12);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];

    NSString *market = @"$0.0 ";
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:market];
    [attributeMarket setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0,market.length)];
    
    _originalPriceLbl=[[UILabel alloc] init];
    _originalPriceLbl.attributedText = attributeMarket;
    _originalPriceLbl.font=FONT_SIZE_MIDDLE;
    _originalPriceLbl.textColor=RGBCOLOR(133, 133, 133);
    _originalPriceLbl.textAlignment=NSTextAlignmentLeft;
    _originalPriceLbl.hidden=YES;
    [self addSubview:_originalPriceLbl];
    
    [_originalPriceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-8);
        make.left.mas_equalTo(_goodsPriceLbl.mas_right);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    
}

-(void)loadData{
    _goodsTitleLbl.text=self.entity.goods_name;
    _goodsPriceLbl.text=[NSString stringWithFormat:@"$%@",self.entity.shop_price];
    [_goodsTitleLbl sizeToFit];
    
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:self.entity.goods_thumb] placeholderImage:[UIImage imageNamed:@"defaut_list"]];
    
}

-(void)selectToStock{
    if(self.delegate&&[self.delegate respondsToSelector:@selector(addToStock:)]){
        [self.delegate addToStock:self.entity.goods_id];
    }
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
