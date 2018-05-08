//
//  HunqinfiveTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/7.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HunqinModel.h"
@interface HunqinfiveTableViewCell : UITableViewCell
@property (strong, nonatomic) RACSubject *gotoNextVc;
@property (weak, nonatomic) IBOutlet UIButton *guanggaoImage;

@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *xiaoguanggao;

@property (nonatomic, strong) Remenhuodong *remenhuodong;
//@property (nonatomic, strong) Xiaoguanggaoyi *xiaoguanggaoyi;

@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *labb1;
@property (weak, nonatomic) IBOutlet UIButton *btn1;

@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *labb2;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *labb3;
@property (weak, nonatomic) IBOutlet UIButton *btn3;

@property (weak, nonatomic) IBOutlet UILabel *lab4;
@property (weak, nonatomic) IBOutlet UILabel *labb4;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property (weak, nonatomic) IBOutlet UILabel *lab5;
@property (weak, nonatomic) IBOutlet UILabel *labb5;
@property (weak, nonatomic) IBOutlet UIButton *btn5;



@end
