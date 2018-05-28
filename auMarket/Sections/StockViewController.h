//
//  StockViewController.h
//  auMarket
//
//  Created by 吴绪伟 on 2018/1/10.
//  Copyright © 2018年 daao. All rights reserved.
//

#import "SPBaseViewController.h"
#import "StockModel.h"
#import "StockCell.h"
#import "QRCodeViewController.h"
#import "GoodsSearchViewController.h"
#import "GoodsListModel.h"

typedef enum:NSInteger{
    INPUT_GOODS_NUM,
    INPUT_GOODS_SERIAL,
    INPUT_GOODS_PRICE,
    INPUT_GOODS_CODE,
    INPUT_SHELF_CODE
} GOODS_INPUT_MODEL;

typedef enum:NSInteger{
    SAVE_THEN_BACK,
    SAVE_THEN_CONTINUE,
} SAVE_MODEL;

@interface StockViewController : SPBaseViewController<PassValueDelegate,UITextFieldDelegate>{
    NSMutableArray *itemArr;
    UIButton *_btn_back;
    UIButton *_btn_next;
    UIAlertView *_inputAlertView;
    UIDatePicker *_datePicker;
    UIToolbar* _keyboardDoneButtonView;
    UIImageView *goods_img;
    UILabel *goodsNameLbl;
    UILabel *goodsPriceLbl;
    UIView *goods_view;
}
@property(nonatomic,retain) StockModel *model;
@property(nonatomic,retain) NSString *goods_id;
@property(nonatomic,retain) NSString *goods_code;
@property(nonatomic,retain) NSString *shelf_code;
@property(nonatomic,assign) GOODS_INPUT_MODEL current_input_model;
@property(nonatomic,assign) SAVE_MODEL save_model;
@property(nonatomic,retain) GoodsListModel *goods_model;
@property(nonatomic,retain) GoodsEntity *scan_entity;
@property(nonatomic,retain) NSString *batch_id;
@end
