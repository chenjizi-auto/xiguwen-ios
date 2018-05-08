//
//  LookMingxiNewTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/2/27.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LookMingxiNewModel.h"

@interface LookMingxiNewTableViewCell : UITableViewCell

//属性
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (strong,nonatomic) Datamingxilook *model;
@property (weak, nonatomic) IBOutlet UILabel *price;

// xib

@end
