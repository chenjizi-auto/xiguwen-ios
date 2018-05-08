//
//  ShangchengFenleiTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/2/28.
//Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShangchengFenleiModel.h"

@interface ShangchengFenleiTableViewCell : UITableViewCell

//属性
@property (strong,nonatomic) Shangchengfenlei *model;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIView *red;

// xib

@end
