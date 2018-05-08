//
//  FayangaoTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/3.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FayangaoModel.h"

@interface FayangaoTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) Fayangaoarray *model;

// xib
@property (weak, nonatomic) IBOutlet UIButton *shanchuBtn;
@property (weak, nonatomic) IBOutlet UIButton *bianjiBtn;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIView *btoVIew;



@end
