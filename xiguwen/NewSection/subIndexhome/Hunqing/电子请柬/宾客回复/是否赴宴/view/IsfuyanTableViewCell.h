//
//  IsfuyanTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/3.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IsfuyanModel.h"

@interface IsfuyanTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) Fuyan *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *number;

@end
