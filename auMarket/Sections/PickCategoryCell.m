//
//  GoodsFavoriteListItemCell.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/13.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "PickCategoryCell.h"

@implementation PickCategoryCell
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

    _catImageView=[[UIImageView alloc] init];
    [self addSubview:_catImageView];
    
    [_catImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(56, 56));
    }];
    
    _catTitleLbl=[[UILabel alloc] init];
    _catTitleLbl.text=@"";
    _catTitleLbl.font=DEFAULT_FONT(15.0);
    _catTitleLbl.numberOfLines=0;
    _catTitleLbl.lineBreakMode=NSLineBreakByWordWrapping;
    _catTitleLbl.textColor=COLOR_FONT_GOODS_CATEGORY;
    _catTitleLbl.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_catTitleLbl];
    
    [_catTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(_catImageView.mas_right).offset(12);
        make.right.mas_equalTo(self.mas_right).offset(-10);
    }];
    
}

-(void)loadData{
    _catTitleLbl.text=self.entity.cat_name;
    [_catImageView sd_setImageWithURL:[NSURL URLWithString:self.entity.cat_icon] placeholderImage:[UIImage imageNamed:@"defaut_list"]];
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
