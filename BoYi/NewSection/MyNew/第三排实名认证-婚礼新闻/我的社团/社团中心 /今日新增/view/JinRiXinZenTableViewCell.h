//
//  JinRiXinZenTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/16.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JinRiXinZenModel.h"

@interface JinRiXinZenTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) JinRiXinZenModel *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *beforeTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end
