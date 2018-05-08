//
//  StockSettingView.h
//  BoYi
//
//  Created by Niklaus on 2018/4/11.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyGoodsModel.h"

@interface StockSettingView : UIView

@property (nonatomic, copy) void(^onSaveBlock)(SkuModel *model);

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *saveBtn;

@property (nonatomic, strong) UITextField *typeOne;
@property (nonatomic, strong) UITextField *typeTwo;
@property (nonatomic, strong) UITextField *priceTF;
@property (nonatomic, strong) UITextField *numberTF;


- (void)show;

- (void)dismiss;

@end
