//
//  NewShangjiaTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/21.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewShangjiaModel.h"

@interface NewShangjiaTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) NewShangjiaModel *model;

// xib
@property (weak, nonatomic) IBOutlet UIButton *iphonebtn;

@property (weak, nonatomic) IBOutlet UIImageView *fengmianImage;
@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *ruanduimingcheng;
@property (weak, nonatomic) IBOutlet UILabel *liulanshuliang;
@property (weak, nonatomic) IBOutlet UILabel *chengjiaoshuliang;
@property (weak, nonatomic) IBOutlet UILabel *haopinshuliang;
@property (weak, nonatomic) IBOutlet UILabel *fansnumber;


@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage1;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage2;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage3;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage4;

@property (weak, nonatomic) IBOutlet UIImageView *huang1;
@property (weak, nonatomic) IBOutlet UIImageView *huang2;
@property (weak, nonatomic) IBOutlet UIImageView *huang3;
@property (weak, nonatomic) IBOutlet UIImageView *huang4;
@property (weak, nonatomic) IBOutlet UIImageView *huang5;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *weiyi;

@end
