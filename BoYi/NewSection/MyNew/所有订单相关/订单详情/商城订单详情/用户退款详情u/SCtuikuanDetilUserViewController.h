//
//  SCtuikuanDetilUserViewController.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/9.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"

@interface SCtuikuanDetilUserViewController : FatherViewController
@property (assign,nonatomic)NSInteger id;




@property (strong, nonatomic) NSString *timeshengyunumber;

@property (weak, nonatomic) IBOutlet UILabel *titleState;
@property (weak, nonatomic) IBOutlet UILabel *timeShengyu;



@property (weak, nonatomic) IBOutlet UIButton *btn1;


@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *yanseChima;
@property (weak, nonatomic) IBOutlet UILabel *priceD;
@property (weak, nonatomic) IBOutlet UILabel *number;


@property (weak, nonatomic) IBOutlet UILabel *bianhao;
@property (weak, nonatomic) IBOutlet UILabel *shenqintime;
@property (weak, nonatomic) IBOutlet UILabel *shifuJine;
@property (weak, nonatomic) IBOutlet UILabel *shenqinNumber;
@property (weak, nonatomic) IBOutlet UILabel *yuanyin;
@end
