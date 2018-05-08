//
//  MyTuceTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/19.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTuceModel.h"

@interface MyTuceTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) MyTuceModel *model;

// xib
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImg;


@end
