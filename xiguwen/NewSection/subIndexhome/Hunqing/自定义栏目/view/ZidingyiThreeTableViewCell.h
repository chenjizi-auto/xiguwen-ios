//
//  ZidingyiThreeTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/1/5.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TebieTuijianModel.h"
@interface ZidingyiThreeTableViewCell : UITableViewCell
//属性
@property (strong,nonatomic) Guanggaoarray *model;

// xib
@property (weak, nonatomic) IBOutlet UIImageView *imagew;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIView *dibuview;
@end
