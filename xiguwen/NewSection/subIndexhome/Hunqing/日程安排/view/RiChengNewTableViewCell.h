//
//  RiChengNewTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/3.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RiChengNewModel.h"

@interface RiChengNewTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) Newrichengarray *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *imagew;

@property (nonatomic, copy) void(^onSendModel)(Newrichengarray *model);
@property (weak, nonatomic) IBOutlet UIView *btmView;

@end
