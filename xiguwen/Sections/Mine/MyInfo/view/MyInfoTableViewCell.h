//
//  MyInfoTableViewCell.h
//  BoYi
//
//  Created by Chen on 2017/8/13.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyInfoModel.h"

@interface MyInfoTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) MyInfoModel *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIImageView *header;
@property (weak, nonatomic) IBOutlet UILabel *value;

@end
