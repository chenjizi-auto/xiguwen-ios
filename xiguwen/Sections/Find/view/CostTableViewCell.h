//
//  CostTableViewCell.h
//  BoYi
//
//  Created by apple on 2017/8/21.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CostModel.h"

@interface CostTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) RowsGB *model;
@property (weak, nonatomic) IBOutlet UILabel *name;

// xib
@property (weak, nonatomic) IBOutlet UILabel *number;

@end
