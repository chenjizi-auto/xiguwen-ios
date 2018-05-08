//
//  OrderDetilNewJDViewController.h
//  BoYi
//
//  Created by heng on 2018/4/7.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "FatherViewController.h"
#import "OrderDetilModelNew.h"
@interface OrderDetilNewJDViewController : FatherViewController

@property (assign,nonatomic)NSInteger id;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *leftBtn;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *rightBtn;


@property (strong, nonatomic) NSString *timeshengyunumber;

@property (nonatomic,strong)OrderDetilModelNew *model;
@property (weak, nonatomic) IBOutlet UILabel *titleState;
@property (weak, nonatomic) IBOutlet UILabel *timeShengyu;



@property (weak, nonatomic) IBOutlet UILabel *shangjianame;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *isMoneyType;
@property (weak, nonatomic) IBOutlet UILabel *priceD;
@property (weak, nonatomic) IBOutlet UILabel *priceDing;
@property (weak, nonatomic) IBOutlet UILabel *number;

@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *actionBtn;


@property (weak, nonatomic) IBOutlet UILabel *zongjia;
@property (weak, nonatomic) IBOutlet UILabel *dikou;
@property (weak, nonatomic) IBOutlet UILabel *dingjin;
@property (weak, nonatomic) IBOutlet UILabel *fanxiandikou;

@property (weak, nonatomic) IBOutlet UILabel *yinfuzonge;
@property (weak, nonatomic) IBOutlet UILabel *yinfujine;
@property (weak, nonatomic) IBOutlet UILabel *yifuzonge;



@property (weak, nonatomic) IBOutlet UILabel *bianhao;
@property (weak, nonatomic) IBOutlet UILabel *xiadantime;
@property (weak, nonatomic) IBOutlet UILabel *chucifukuantime;
@property (weak, nonatomic) IBOutlet UILabel *weikuantime;
@property (weak, nonatomic) IBOutlet UILabel *wanchengtime;
@end
