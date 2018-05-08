//
//  MyCaseTableViewCell.h
//  BoYi
//
//  Created by Yifei Li on 2017/8/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCaseModel.h"

@interface MyCaseTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) MyCaseModel *model;

// xib
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *eventBtn;

@end
