//
//  MingxiNewTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/12.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MingxiNewModel.h"

@interface MingxiNewTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) MingxiNewModel *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *payTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UIView *dibuView;

@end
