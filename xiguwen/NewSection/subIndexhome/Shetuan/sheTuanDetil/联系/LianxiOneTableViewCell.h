//
//  LianxiOneTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/16.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShetuanLinxiModel.h"
@interface LianxiOneTableViewCell : UITableViewCell
@property (nonatomic,strong)ChuangshirenLianxi *model;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *iphone;
@end
