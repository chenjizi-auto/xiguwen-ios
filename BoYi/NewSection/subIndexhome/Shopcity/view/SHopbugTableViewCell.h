//
//  SHopbugTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/2/10.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopcityModel.h"
@interface SHopbugTableViewCell : UITableViewCell

@property (strong,nonatomic) ShopcityModel *model;

@property (strong, nonatomic) RACSubject *gotoNextVc;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UIImageView *image4;
@property (weak, nonatomic) IBOutlet UIImageView *iamge5;
@property (weak, nonatomic) IBOutlet UIImageView *image6;
@end
