//
//  HunliXInwenTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/17.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HunliXInwenModel.h"

@interface HunliXInwenTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) HunliXInwenModel *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *showImage;


@end
