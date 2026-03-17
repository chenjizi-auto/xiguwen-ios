//
//  MyConcernTableViewCell.h
//  BoYi
//
//  Created by Chen on 2017/8/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyConcernModel.h"

@interface MyConcernTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) MyConcernModel *model;

// xib
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet IB_DESIGN_Button *eventBtn;

@end
