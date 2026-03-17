//
//  XieshangLishiTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/14.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XieshangLishiModel.h"

@interface XieshangLishiTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) Xieshangarray *model;

// xib
@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *header;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIView *btmview;

@end
