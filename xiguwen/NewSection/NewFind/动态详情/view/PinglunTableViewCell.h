//
//  PinglunTableViewCell.h
//  BoYi
//
//  Created by heng on 2018/2/14.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DongtaiDetilModel.h"
@interface PinglunTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *headerimage;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *jianjie;
@property (weak, nonatomic) IBOutlet UIButton *pinlunBTN;
@property (strong, nonatomic) CommentlistDongtai *model;
@end
