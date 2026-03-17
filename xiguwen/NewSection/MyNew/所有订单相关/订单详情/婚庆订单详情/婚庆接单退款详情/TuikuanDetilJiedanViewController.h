//
//  TuikuanDetilJiedanViewController.h
//  BoYi
//
//  Created by heng on 2018/1/15.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"

@interface TuikuanDetilJiedanViewController : FatherViewController

@property (assign,nonatomic)NSInteger id;




@property (strong, nonatomic) NSString *timeshengyunumber;

@property (weak, nonatomic) IBOutlet UILabel *titleState;
@property (weak, nonatomic) IBOutlet UILabel *timeShengyu;

@property (weak, nonatomic) IBOutlet UILabel *tuikuanzhuangtai;


@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;



@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *isMoneyType;
@property (weak, nonatomic) IBOutlet UILabel *priceD;
@property (weak, nonatomic) IBOutlet UILabel *priceDing;
@property (weak, nonatomic) IBOutlet UILabel *number;


@property (weak, nonatomic) IBOutlet UILabel *bianhao;
@property (weak, nonatomic) IBOutlet UILabel *shenqintime;
@property (weak, nonatomic) IBOutlet UILabel *shifuJine;
@property (weak, nonatomic) IBOutlet UILabel *shenqinNumber;
@property (weak, nonatomic) IBOutlet UILabel *yuanyin;

@property (weak, nonatomic) IBOutlet UILabel *dingTitle;

@end
