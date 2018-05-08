//
//  FuWuCityMyTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/20.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FuWuCityMyModel.h"

@interface FuWuCityMyTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) FuWuCityMyModel *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
