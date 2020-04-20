//
//  goodsBindViewController.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/8.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "SPBaseViewController.h"
#import "QRCodeViewController.h"
#import "PickModel.h"
#import "BlockPickGoodsViewController.h"

@interface BlockPickStartViewController : SPBaseViewController<UIActionSheetDelegate,UITextFieldDelegate,PassValueDelegate>
{
    UIView *cartView;
    UIView *blockView;
    UILabel *lblCartNum;
    UILabel *lblBlockName;
    NSIndexPath *current_confirm_path;
    UIButton *beginBtn;
    NSString *scan_cart_num;
    NSString *scan_block_id;
}
@property(nonatomic,retain) PickModel *model;
@end
