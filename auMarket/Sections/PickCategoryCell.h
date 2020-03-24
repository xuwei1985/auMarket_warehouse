//
//  GoodsFavoriteListItemCell.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/13.
//  Copyright © 2016年 daao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BatchPickCategoryEntity.h"

@interface PickCategoryCell : UITableViewCell{
    UILabel *_catTitleLbl;
    UILabel *_goodsnumLbl;
    UIImageView *_catImageView;
}

@property(nonatomic,retain)PickCategoryEntity *entity;

@end
