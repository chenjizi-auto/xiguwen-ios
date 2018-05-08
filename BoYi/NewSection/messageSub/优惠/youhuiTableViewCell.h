//
//  youhuiTableViewCell.h
//  BoYi
//
//  Created by 千嘉公司 on 2018/4/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "youhuiModel.h"
@interface youhuiTableViewCell : UITableViewCell
@property (strong, nonatomic) Contyouhui *model;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UIImageView *headerimage;


@end
