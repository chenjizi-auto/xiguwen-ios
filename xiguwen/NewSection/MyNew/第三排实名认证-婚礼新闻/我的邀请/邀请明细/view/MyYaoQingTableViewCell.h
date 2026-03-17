//
//  MyYaoQingTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/17.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyYaoQingModel.h"

@interface MyYaoQingTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) InvitationArray *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
