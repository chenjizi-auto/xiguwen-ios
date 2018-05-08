//
//  shangchengTwoTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/9.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopcityModel.h"
@interface shangchengTwoTableViewCell : UITableViewCell
@property (strong,nonatomic) ShopcityModel *model;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *image1;


@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *image2;
@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *image3;
@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *image4;
@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *iamge5;
@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *image6;
@property (strong, nonatomic) RACSubject *gotoNextVc;
@end
