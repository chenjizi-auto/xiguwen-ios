//
//  BingkeHuifuTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/3.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BingkeHuifuModel.h"

@interface BingkeHuifuTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) Zhufu *model;

// xib
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end
