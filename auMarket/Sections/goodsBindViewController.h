//
//  goodsBindViewController.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/8.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "SPBaseViewController.h"
#import "GoodsBindCell.h"

@interface goodsBindViewController : SPBaseViewController<UIActionSheetDelegate>
{
    UILabel *lbl_goodsNum;
    UILabel *lbl_sumPrice;
    UIButton *_btn_doneAction;
}
@end
