//
//  JizhangZhuShouTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/22.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JizhangZhuShouModel.h"

@interface JizhangZhuShouTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) Tianjizhang *model;

// xib
@property (weak, nonatomic) IBOutlet UIImageView *imagew;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *mingxi;

@end
