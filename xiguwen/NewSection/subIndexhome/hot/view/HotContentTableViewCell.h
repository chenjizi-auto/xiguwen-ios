//
//  HotContentTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/11.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotModel.h"
@interface HotContentTableViewCell : UITableViewCell

@property (strong,nonatomic) Remensjhot *model;
@property (weak, nonatomic) IBOutlet UIImageView *headerimage;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *zhiwei;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIImageView *isHuiyuan;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage1;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage2;
@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage3;

@property (weak, nonatomic) IBOutlet UIImageView *renzhengImage4;
@property (weak, nonatomic) IBOutlet UILabel *shangpin;
@property (weak, nonatomic) IBOutlet UILabel *anlie;
@property (weak, nonatomic) IBOutlet UILabel *pingjia;
@end
