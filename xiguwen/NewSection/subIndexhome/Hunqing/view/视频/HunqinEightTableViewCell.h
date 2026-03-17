//
//  HunqinEightTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/8.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HunqinModel.h"
@interface HunqinEightTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) Youlike *model;

@property (weak, nonatomic) IBOutlet UIImageView *bigImage;

@property (weak, nonatomic) IBOutlet UIView *btmView;

@property (weak, nonatomic) IBOutlet UILabel *occupationid;

@property (weak, nonatomic) IBOutlet UIImageView *headrImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *guanzhuBtn;
@property (weak, nonatomic) IBOutlet UILabel *qianming;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *jianjie;
@property (weak, nonatomic) IBOutlet UILabel *liulanNumber;
@property (weak, nonatomic) IBOutlet UIImageView *liulanImage;

@property (weak, nonatomic) IBOutlet UILabel *guanzhuNumber;
@property (weak, nonatomic) IBOutlet UIImageView *guanzhuImage;

@property (weak, nonatomic) IBOutlet UILabel *pinglunNumber;
@property (weak, nonatomic) IBOutlet UIImageView *pinglunImage;

@end
