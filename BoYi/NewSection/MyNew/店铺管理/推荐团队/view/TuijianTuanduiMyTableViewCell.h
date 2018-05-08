//
//  TuijianTuanduiMyTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/22.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TuijianTuanduiMyModel.h"

@interface TuijianTuanduiMyTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) TuijianTuanduiMyModel *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *serialLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;

@end
