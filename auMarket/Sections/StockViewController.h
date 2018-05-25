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

typedef enum:NSInteger{
    INPUT_GOODS_NUM,
    INPUT_GOODS_SERIAL,
    INPUT_GOODS_PRICE,
    INPUT_GOODS_CODE,
    INPUT_SHELF_CODE
} GOODS_INPUT_MODEL;

@interface StockViewController : SPBaseViewController<PassValueDelegate,UITextFieldDelegate>{
    NSMutableArray *itemArr;
    UIButton *_btn_back;
    UIButton *_btn_next;
    UIAlertView *_inputAlertView;
    UIDatePicker *_datePicker;
    UIToolbar* _keyboardDoneButtonView;
}
@property(nonatomic,retain) StockModel *model;
@property(nonatomic,retain) NSString *goods_code;
@property(nonatomic,retain) NSString *shelf_code;
@property(nonatomic,assign) GOODS_INPUT_MODEL current_input_model;
@end
