//
//  ZiliaoNewTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/20.
//Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shangjiaZiliaoModel.h"
@interface ZiliaoNewTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) shangjiaZiliaoModel *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *iphone;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *height;
@property (weak, nonatomic) IBOutlet UILabel *weight;
@property (weak, nonatomic) IBOutlet UILabel *city;

@end
