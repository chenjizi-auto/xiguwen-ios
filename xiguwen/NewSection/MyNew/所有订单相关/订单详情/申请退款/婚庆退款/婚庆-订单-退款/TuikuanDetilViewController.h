//
//  TuikuanDetilViewController.h
//  BoYi
//
//  Created by heng on 2018/1/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"

@interface TuikuanDetilViewController : FatherViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (assign,nonatomic)NSInteger id;
@property (weak, nonatomic) IBOutlet UILabel *titleState;
@property (weak, nonatomic) IBOutlet UILabel *timeShengyu;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *isMoneyType;
@property (weak, nonatomic) IBOutlet UILabel *priceD;
@property (weak, nonatomic) IBOutlet UILabel *priceDing;
@property (weak, nonatomic) IBOutlet UILabel *number;

@property (weak, nonatomic) IBOutlet UILabel *bianhao;
@property (weak, nonatomic) IBOutlet UILabel *shenqintime;
@property (weak, nonatomic) IBOutlet UILabel *fukuanjine;
@property (weak, nonatomic) IBOutlet UILabel *shenqinNumber;
@property (weak, nonatomic) IBOutlet UILabel *tuikuanYuanyin;


@property (weak, nonatomic) IBOutlet UIView *isYinCangView;
@property (weak, nonatomic) IBOutlet UILabel *isYinCangTitle;
@property (weak, nonatomic) IBOutlet UILabel *isYinCangContent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *isYinCangHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollHegit;

@property (weak, nonatomic) IBOutlet UIButton *actionBtn;

@property (weak, nonatomic) IBOutlet UILabel *dingTitle;


@end
