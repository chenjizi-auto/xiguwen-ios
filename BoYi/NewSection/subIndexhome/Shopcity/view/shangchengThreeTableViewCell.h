//
//  shangchengThreeTableViewCell.h
//  BoYi
//
//  Created by heng on 2017/12/9.
//  Copyright © 2017年 hengwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopcityModel.h"
@interface shangchengThreeTableViewCell : UITableViewCell

@property (strong,nonatomic) Remenshangpinsc *model;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *guanzhuBTN;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *like;
@property (weak, nonatomic) IBOutlet IB_DESIGN_ImageView *headerimage;



@end
