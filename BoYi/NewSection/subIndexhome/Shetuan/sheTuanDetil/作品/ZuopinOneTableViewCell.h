//
//  ZuopinOneTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/16.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shetuanZuppinModel.h"
@interface ZuopinOneTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) Chuangshirenzuopin *model;
@end
