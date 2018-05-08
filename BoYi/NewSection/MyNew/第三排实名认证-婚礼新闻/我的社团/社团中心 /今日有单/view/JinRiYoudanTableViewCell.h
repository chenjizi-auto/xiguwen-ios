//
//  JinRiYoudanTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/17.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JinRiYoudanModel.h"

@interface JinRiYoudanTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) JinRiYoudanModel *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
